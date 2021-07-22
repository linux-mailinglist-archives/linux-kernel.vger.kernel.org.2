Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33A473D26D5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 17:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbhGVO5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 10:57:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:39044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232488AbhGVO5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 10:57:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 52F186052B;
        Thu, 22 Jul 2021 15:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626968299;
        bh=8nuwoZzIE9AXZnCM6wlUP00pAGYzYvAAKw+DrOsiFF4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GsDuiPbntO7mTbUHw/OMga6TpqxPzd1jVux3hSo8uaiVGT/FS1jJae4yyYqKXGFPa
         Tjh6LTF4MnLRwrMll7/BPTadvvds5880xaeoagTdakty199n46NPakMNOgptqU60cB
         P5gGX1qTC+Ri2ieYZ9XnV9h5HL+OIVKQciK2b4R4Mr/rNkCSUGXMt5qHwU6bIPeHqL
         OkhSNafLRHVCfxswugOTMybYqAbgOigkhZPr/eOPPP4Z9PWTsLf2BWWk17ESMh5rQS
         H+JD683PNUSwyaJGSrvqTMkk9WF3ym5GZXT3StPbQ9iWybwgJGZ5DxLDBOFkaC2VZb
         5g3p3JN4p62sg==
Date:   Thu, 22 Jul 2021 16:38:15 +0100
From:   Will Deacon <will@kernel.org>
To:     Vladimir Murzin <vladimir.murzin@arm.com>
Cc:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
        "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
        "maz@kernel.org" <maz@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 3/3] kvm/arm: Align the VMID allocation with the arm64
 ASID one
Message-ID: <20210722153814.GA12566@willie-the-truck>
References: <20210616155606.2806-1-shameerali.kolothum.thodi@huawei.com>
 <20210616155606.2806-4-shameerali.kolothum.thodi@huawei.com>
 <20210721163138.GD11003@willie-the-truck>
 <f7d708704fb84380af85298a98f7a48c@huawei.com>
 <20210722095010.GA12012@willie-the-truck>
 <43b32e77-52b1-8524-63a1-c99578c2dd1d@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43b32e77-52b1-8524-63a1-c99578c2dd1d@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vladimir,

On Thu, Jul 22, 2021 at 04:22:26PM +0100, Vladimir Murzin wrote:
> On 7/22/21 10:50 AM, Will Deacon wrote:
> > As an aside: I'm more and more inclined to rip out the CnP stuff given
> > that it doesn't appear to being any benefits, but does have some clear
> > downsides. Perhaps something for next week.
> 
> Can you please clarify what do you mean by "it doesn't appear to being any
> benefits"? IIRC, Cortex-A65 implements CnP hint and I've heard that some
> payloads seen improvement...

Has anybody taped that out? I'd have thought building an SMT design in 2021
is a reasonably courageous thing to do.

The issue I'm getting at is that modern cores seem to advertise CnP even
if they ignore it internally, maybe because of some big/little worries?
That would be fine if it didn't introduce complexity and overhead to the
kernel, but it does and therefore I think we should rip it out (or at
least stick it behind a "default n" config option if there are some niche
users).

There are also open questions as to exactly what CnP does because the
architecture is not clear at all (for example TTBRx_EL1.CnP is permitted
to be cached in a TLB).

CHeers,

Will

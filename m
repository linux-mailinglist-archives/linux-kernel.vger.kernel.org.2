Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 978C1393456
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 18:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236648AbhE0Qzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 12:55:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:46976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234803AbhE0Qze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 12:55:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E8A7F613B5;
        Thu, 27 May 2021 16:53:58 +0000 (UTC)
Date:   Thu, 27 May 2021 17:53:56 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Bhupesh SHARMA <bhupesh.sharma@linaro.org>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Dave Young <dyoung@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, kernel-team@android.com
Subject: Re: [PATCH 2/4] kernel/resource: Populate child pointer in
 find_next_iomem_res()
Message-ID: <20210527165355.GF8661@arm.com>
References: <20210526190531.62751-1-maz@kernel.org>
 <20210526190531.62751-3-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210526190531.62751-3-maz@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 08:05:29PM +0100, Marc Zyngier wrote:
> When find_next_iomem_res() returns a resource, it doesn't
> populate the child pointer (but does so with the parent).
> 
> As we are about to need to arse child resources, populate
> this pointer as well.

Did you mean "parse"? ;)

-- 
Catalin

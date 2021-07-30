Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79B843DB051
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 02:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235351AbhG3Aeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 20:34:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:59204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229523AbhG3Aen (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 20:34:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E147860F21;
        Fri, 30 Jul 2021 00:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627605279;
        bh=1wQmyo8eNOcr9cXmmngpz+YRFMvD4gq8n8FjNL7Mh4M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p/7ffPdIbPw9cBZ0xWmJskPPSVAYGuOH4E3AaydpccM5z3j0zSy0l/pFemGUM/BH7
         mqdDemT4r0tAiU6NFYuJoIr2oKPgH6JPlsgSoOcS6fwywvWHSRB6xGefFwotFUdvPf
         EWDWTv2j82iGq0UDBl5WmV4ZmAn98nHXlWNUV7+eHQmEi8kbcQjvy1Eh/xeNgF00/q
         TWjzAGq6xvao+G33m09gX1wBNH3IBnChc9CDqah0QR+dbg+VE2sAb+aGhPWwqLJkX2
         S1lK21i9ZySVy4VykoiwI/HcGFi9ypkZz/oIS+g3s1FK7pYpn7f7NAEHuJg7w0A61c
         bRfYa5+2Eqhyg==
Date:   Fri, 30 Jul 2021 03:34:35 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     "Hansen, Dave" <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/7] x86/sgx: Provide indication of life-cycle of EPC
 pages
Message-ID: <20210730003435.bge53hlxpzpijdw7@kernel.org>
References: <20210719182009.1409895-1-tony.luck@intel.com>
 <20210728204653.1509010-1-tony.luck@intel.com>
 <20210728204653.1509010-2-tony.luck@intel.com>
 <17054ca5-0ef7-4b28-ab26-b1b96aa7403f@intel.com>
 <f2685d7c8dc14792a4e0f9807f742ea6@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2685d7c8dc14792a4e0f9807f742ea6@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 10:57:07PM +0000, Luck, Tony wrote:
> > Wouldn't it be safer to do something like:
> >
> >	page->owner = owner ? owner : (void *)-1;
> >
> > -1 is non-NULL, but also invalid, which makes it harder for us to poke
> > ourselves in the eye.
> 
> Does Linux have some #define INVALID_POINTER thing that
> provides a guaranteed bad (e.g. non-canonical) value?
> 
> (void *)-1 seems hacky.
> 
> -Tony

MAP_FAILED?

/Jarkko

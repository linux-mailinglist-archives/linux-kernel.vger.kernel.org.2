Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EAE13E22D6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 07:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243055AbhHFFSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 01:18:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:50386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240658AbhHFFSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 01:18:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5A9ED611C9;
        Fri,  6 Aug 2021 05:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628227072;
        bh=HHDwMPDhQd31WUDg2yNG4zsdt0gODM4KSj7IzsG0d6o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L4fzPjJJUTFkd5AsX6mdvrqupvJcVmu/lzg9vYQCzfJbn6EOH6K4MhWZQ9TnQ4d2+
         BByIuPIBFaYdp2t31KZRJkvaWr3a/oamUBWN2zJdm+Gu50uO/qETmyY5R280+EwItZ
         hL2TJgLVf0AxLKq4LCOZ5vCYrgXIoUDu3F8NjtCg=
Date:   Fri, 6 Aug 2021 07:17:50 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v1] driver: base: Add driver filter support
Message-ID: <YQzF/utgrJfbZuHh@kroah.com>
References: <YQuZdVuaGG/Cr62y@kroah.com>
 <YQuaJ78y8j1UmBoz@kroah.com>
 <fdf8b6b6-58c3-8392-2fc6-1908a314e991@linux.intel.com>
 <YQwlHrJBw79xhTSI@kroah.com>
 <21db8884-5aa1-3971-79ef-f173a0a95bef@linux.intel.com>
 <YQwpa+LAYt7YZ5dh@kroah.com>
 <1e0967ee-c41e-fd5d-f553-e4d7ab88838c@linux.intel.com>
 <CAPcyv4h26QmPhJKjtUB-VPc4TP95rBAer78OzkgXncg77tFWVw@mail.gmail.com>
 <9b2956f5-3acf-e798-ff0f-002d2d5254db@linux.intel.com>
 <CAPcyv4ju0kzUuamiuE=xC_DoEArk1KxD+n+-TUw0LLTWoSj2VA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4ju0kzUuamiuE=xC_DoEArk1KxD+n+-TUw0LLTWoSj2VA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2021 at 06:00:25PM -0700, Dan Williams wrote:
> That said, per-device authorization is a little bit different than
> per-driver trust. Driver trust is easy to reason about for a built-in
> policy, while per-device authorization is easy for userspace to reason
> about for "why is this device not talking to its driver?".

See my other email about how the "per driver" trust is the wrong model,
you need to stick to "per device" trust.  Especially given that you are
giving control of your kernel drivers over to third parties, you already
trust them to do the right thing.

thanks,

greg k-h

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A32342F6AF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 17:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240864AbhJOPNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 11:13:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:58486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230430AbhJOPNH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 11:13:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D86516120A;
        Fri, 15 Oct 2021 15:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634310661;
        bh=3jYoDtUPdFBEUryZYNHsyBzPurObUQOppTxdHPamp+Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SifqW+tmi83vgBOT/JG7an3SFgEf3U28avuIKl5gdn4/f/gwrbRGm3iB33QKZMh2h
         l/YFf6zbXWcmWmBz3JoYpQacXmxoGeDyp2fEr9h6qQ+iY5x6Y7R9Jxum9CMNImVdbE
         Z9xC2Ny5MQVrzuUhc/r9+Pk5Rp1Nl1N+SSUMezPA=
Date:   Fri, 15 Oct 2021 17:10:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Karolina Drobnik <karolinadrobnik@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, forest@alittletooquiet.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: vt6655: Rename byPreambleType field
Message-ID: <YWmaAqf8pusZGoBd@kroah.com>
References: <20211015102444.90753-1-karolinadrobnik@gmail.com>
 <YWlj9x6kwYUT1jlQ@kroah.com>
 <85dfe2c18e7ec4bd5ae67f7a81ab6197a82e0d86.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85dfe2c18e7ec4bd5ae67f7a81ab6197a82e0d86.camel@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 03:47:46PM +0100, Karolina Drobnik wrote:
> Hi Greg,
> 
> On Fri, 2021-10-15 at 13:20 +0200, Greg KH wrote:
> > Do not do multiple different things in the same commit and especially
> > when you do not describe them in the changelog text.
> 
> I wasn't aware that changing this preamble-related variable would be
> counted as a different thing. It makes sense, my bad.
> 
> Would you like me to amend the message to say that I also changed
> `bb_get_frame_time` parameter or just drop this change completely?

I think I already answered this :)


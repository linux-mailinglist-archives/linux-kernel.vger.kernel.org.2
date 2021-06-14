Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 595313A5B29
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 02:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbhFNAU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 20:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbhFNAU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 20:20:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3DDC061574;
        Sun, 13 Jun 2021 17:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=QT899P7cnZ+OavoKwMjdK7EHSjBMVrz89zrq8vC4muU=; b=FVTM/S6kVb8n2Xu/KQzgMF6Wcy
        TMnTODUE3+WxGnow6MVXu9GH0At649lNh6N7iOTpGLTjvv/dy/HgZzZBrNkipxWR7+koSq6fI+Kww
        azH3cc4mk2pjj0K4Cqj5xaWj/NxVFAQGzO5KdHlqlgMAgEsg9EG2uev325UQcn8esarGdH6P2AUNs
        U522fjJR2OWCeVbo8gGuUmKks3vFCrXKtxEA8OW4VH13fdNky93iYkJOu1dHG2k/jgpPOEWfbOle2
        C0H9je3pIzuGExInNQtvDeSjNX7RmJqVVicrL2qKqMwyaYxxXTu8btAz3yeKvfbaMjFmXVB8YoCzk
        Af+0lcRw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lsaIm-004u8i-J2; Mon, 14 Jun 2021 00:18:08 +0000
Date:   Mon, 14 Jun 2021 01:18:04 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Hu Haowen <src.res@email.cn>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: add traditional Chinese translation for kernel
 Documentation
Message-ID: <YMagPMuKYKWDpUj8@casper.infradead.org>
References: <20210607132414.44601-1-src.res@email.cn>
 <4ecfaca0-801b-1827-2d6a-13690e016957@email.cn>
 <87wnqxbcjb.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87wnqxbcjb.fsf@meer.lwn.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 13, 2021 at 04:55:04PM -0600, Jonathan Corbet wrote:
> Hu Haowen <src.res@email.cn> writes:
> > 在 2021/6/7 下午9:24, Hu Haowen 写道:
> >> Add traditional Chinese translation (zh_TW) for the Linux Kernel
> >> documentation with a series of translated files.
> >
> > Is this patch applied? I have another amount of changes on this, so
> > please handle it as soon as possible.
> 
> I have been away from the keyboard for the last week, and haven't had a
> chance to look at it yet.  That will happen soon.  Meanwhile, please be
> patient; it has not yet even been a week since you posted this work.
> 
> Taking a quick look, there are a couple of things you can do:
> 
>  - We have a Chinese translation, now you are creating a different one.
>    Please explain why that is needed?

I think this explains it:

https://stackoverflow.com/questions/4892372/language-codes-for-simplified-chinese-and-traditional-chinese

So if we would consider having (eg) fr_FR and fr_CA, it's reasonable to
have both zh_CN and zh_TW.  No, I'm not volunteering to produce en_GB
(or is that en_UK?)

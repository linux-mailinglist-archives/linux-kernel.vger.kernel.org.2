Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6967F348942
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 07:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbhCYGk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 02:40:59 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:41195 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229448AbhCYGk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 02:40:28 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 6E8D25C00E7;
        Thu, 25 Mar 2021 02:40:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 25 Mar 2021 02:40:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm3; bh=U
        Gj6fMfmoDQ79UlYMp/FzxqG8a8b8C6sD9XhFEAo/G0=; b=a0lT9smorCJ9hbEmx
        7Yuo+h27vb38r4oPRAMxYW8KXEzhrt/XaYBN60j8twhAmskXiyi4sTkB63yKrhwa
        N1l5n8DKk2YI+W+mmU3EYz8HXHTOap2a1fDkIDHnGkBjNZW4Qbx7P0d9WzIntRjT
        Zx1vH9FGClGjKtkzUiL0t9alDJYS6l6zJSitAYlEfNp2ZUJny6qRrU/b7PyoA/31
        EhjGuRT92dKjYNZo373i3SUo/nvUpI01qwf/dLtaWtaCAVainQJRcfUgSZ6xiPzS
        CvJzpH4HppO9U9cPR0d6rV+FsJypB0Ytb2ejJiiSv1LJlCBGspzd3FCblffY1gaW
        GxIfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=UGj6fMfmoDQ79UlYMp/FzxqG8a8b8C6sD9XhFEAo/
        G0=; b=lG16pcmRyZkAzf4aRCZGYMFu1N4BtPXidxAi4V+mSPautkFUK4b+0dqsO
        agjW5Ep33P37n+7k9rVgS8l4t7BYsoxhmZTXBjjMUzftQoLOLaS4tc9KEr2i/OSi
        FTNMqxrqdLW/vSkQZog6TOu7jq1khu4yxLWXKfdB3oA16ntxglcEfTVXm8g3Hu5H
        kRJTRS2AffhqEDlyCIzhivAmQdxI67xxZM/a414zQdHzyE9jvRPT2jOra76IFI9x
        GTG0v9bNFgOM9JiKhRW28cjjyiC2xuPw0oK6elEYUY4m9v7ntd+r7Yxn3CILh7me
        B4l1qAkcuuvlt9pOZ/XYug/fztb2w==
X-ME-Sender: <xms:WjBcYAulgjNDAb7n1cxVJBUT5alJW8td8TZJqXd_Gkh8WLbJpuUlRg>
    <xme:WjBcYNdDAkdaG_8SKGaYD_Xhg9_Gcp4lUZquIQ5AOIFGslyrRXkJrzp-tt7RkD3hx
    bDdv9QZuZlumA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudegledgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtugfgjgesthekredttddtudenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepvedtie
    elueetgeeggfeufefhvefgtdetgfetgfdtvdegjeehieduvddtkeffheffnecukfhppeek
    fedrkeeirdejgedrieegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:WjBcYLxkfjiwnJZwAgKt-Lbk6VzfhDli6YGTNZRlR_1HzR1MQNcpyw>
    <xmx:WjBcYDM4hcagwU0OivCtf8NNoEfJPqrDjCZ50PPjr0lvsOCk5Evi3Q>
    <xmx:WjBcYA-EfnymtPNt8ALMTeNRb_oxk3xOrGJdpd0h7BiteFIcCian_w>
    <xmx:WzBcYPY3-kOLwK6HdYVrPfr3tUsnI3QzQyxlnyVJdISmpnJibQDjfg>
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6FA5524005A;
        Thu, 25 Mar 2021 02:40:26 -0400 (EDT)
Date:   Thu, 25 Mar 2021 07:40:24 +0100
From:   Greg KH <greg@kroah.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>, linux-usb@vger.kernel.org
Subject: Re: [PATCH] tools: usbip: list.h: fix kernel-doc for list_del()
Message-ID: <YFwwWCC8+cMnt/M/@kroah.com>
References: <20210324000223.22043-1-rdunlap@infradead.org>
 <0af7bfad-fff7-84be-8e7c-2ad3e93fb785@linuxfoundation.org>
 <0064f460-de49-98c8-1448-3489aa036384@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0064f460-de49-98c8-1448-3489aa036384@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 06:35:01PM -0700, Randy Dunlap wrote:
> On 3/24/21 4:32 PM, Shuah Khan wrote:
> > On 3/23/21 6:02 PM, Randy Dunlap wrote:
> >> In list.h, the kernel-doc for list_del() should be immediately
> >> preceding the implementation and not separated from it by
> >> another function implementation.
> >>
> >> Eliminates this kernel-doc error:
> >> list.h:1: warning: 'list_del' not found
> >>
> >> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> >> Cc: Valentina Manea <valentina.manea.m@gmail.com>
> >> Cc: Shuah Khan <shuah@kernel.org>
> >> Cc: Shuah Khan <skhan@linuxfoundation.org>
> >> Cc: linux-usb@vger.kernel.org
> >> ---
> >>   tools/usb/usbip/libsrc/list.h |   10 +++++-----
> >>   1 file changed, 5 insertions(+), 5 deletions(-)
> >>
> >> --- linux-next-20210323.orig/tools/usb/usbip/libsrc/list.h
> >> +++ linux-next-20210323/tools/usb/usbip/libsrc/list.h
> >> @@ -77,17 +77,17 @@ static inline void __list_del(struct lis
> >>   #define LIST_POISON1  ((void *) 0x00100100 + POISON_POINTER_DELTA)
> >>   #define LIST_POISON2  ((void *) 0x00200200 + POISON_POINTER_DELTA)
> >>   +static inline void __list_del_entry(struct list_head *entry)
> >> +{
> >> +    __list_del(entry->prev, entry->next);
> >> +}
> >> +
> >>   /**
> >>    * list_del - deletes entry from list.
> >>    * @entry: the element to delete from the list.
> >>    * Note: list_empty() on entry does not return true after this, the entry is
> >>    * in an undefined state.
> >>    */
> >> -static inline void __list_del_entry(struct list_head *entry)
> >> -{
> >> -    __list_del(entry->prev, entry->next);
> >> -}
> >> -
> >>   static inline void list_del(struct list_head *entry)
> >>   {
> >>       __list_del(entry->prev, entry->next);
> >>
> > 
> > Thank you for fixing this.
> > 
> > Acked-by: Shuah Khan <skhan@linuxfoundation.org>
> 
> 
> Thanks. Who do you think should merge this patch?

I can :)

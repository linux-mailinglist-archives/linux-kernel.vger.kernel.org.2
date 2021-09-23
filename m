Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B04D1415C86
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 13:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240517AbhIWLIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 07:08:55 -0400
Received: from wnew1-smtp.messagingengine.com ([64.147.123.26]:38293 "EHLO
        wnew1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240448AbhIWLIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 07:08:54 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.west.internal (Postfix) with ESMTP id 796BC2B013A1;
        Thu, 23 Sep 2021 07:07:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 23 Sep 2021 07:07:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=4Uv/tNCKwDzg+aEvrmuGo3KrlCN
        GXhEcNgQmkBFw8cg=; b=fP3fYUOSoSA6U7DxqijDBzUceRtwGC9OwJ81KBwK/xG
        a8bof5NhECUjIyPAb+SnyIBRJgAEFFjdTQQpxuatnlXl5YMMXXiJGX11L6k0lwPC
        7gVT9r+i4m6cNRQ+JbvLxY5v336s3MCvC9Cmf77OSJDOefjRf+bnzb9A3FFUrTIr
        a2D9fsNktOoqOw/JsyGDefGhrZdW4hVRm33P2Z2OfqB1t+mDFXbKH6wQaQFp9FBx
        vfUYUYhxqs4lRdUMjwAegWhB3EuGBkJh7qViKPgYV1mpOZ5QxhoZdIIAnzMsuQVB
        3AiLjN5nWbyjQPpdelVo506rCgM/OYkYpcESk1acuzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=4Uv/tN
        CKwDzg+aEvrmuGo3KrlCNGXhEcNgQmkBFw8cg=; b=dP8jHhSNEKybmjmWiSOnFV
        SyS2G923e9782srbqyilxsp8nRZwuF8GAqTYPilCaHpbsJdsO3OOzWSVhi5CbdVw
        r4FZNprbZx0EHgsJzfQ6tWvIoQER0qk4OF1j8vNqwGu7ZgRSywfN9jQbqaPK0s29
        rkN7znuxUiMo7XJ7iV7S5TG/bZLOCKyPAS6ABYE9ddfZPWhGm/zGTilexVvc5Il3
        r7Xu2D/rHomrWjRic7HTB7yzEAEMj5NGZtJgplLZa4imHahzvO8PDQ50BfKV+dm5
        f8y+7525Q0JN/QshPIuVE/W5NLclkLBt1JUdnKFpMSHb4FzGJm0FxMQf3DtFqX/w
        ==
X-ME-Sender: <xms:6F9MYce_kNLuWbcMoAjtDOo-iYoOZMP3KbJX08040x8dwYEfEmqABg>
    <xme:6F9MYeONWFnrBsVf-ZhQr-yknRLP0uYPkYzpIcmqCsck1nh31PBEvX_6jgDQVhsqk
    CMO5z4LwtBy-w>
X-ME-Received: <xmr:6F9MYdiz0jhaTXFoBDqndkdyp7r3irxHLGm4e5d60ao6AbICgmAzHnV29zxFgwjRBKfzRKJoeWRcVJ9PL56rKbyorkwbsInS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudeiledgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeevueehje
    fgfffgiedvudekvdektdelleelgefhleejieeugeegveeuuddukedvteenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhh
    drtghomh
X-ME-Proxy: <xmx:6F9MYR8PTt-WnodIwR48XYXRXQRqaQfWu3fRpQfprMvrOCebBorEFQ>
    <xmx:6F9MYYsOqkS0BEZ7AshAL5gCdcVQSfcPsLn0YB4byNi97VAE5IGufA>
    <xmx:6F9MYYGvg3jx_m-b6T5R0p0nPvkgVVQs8YJkaDClxcTNFteJ8mKiZg>
    <xmx:6V9MYZ-Y_uNE7UARq8Y5i4My-N6J7IPbIRBh9tBNifCe8XyFLRMPp-VmdN4>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Sep 2021 07:07:19 -0400 (EDT)
Date:   Thu, 23 Sep 2021 13:07:17 +0200
From:   Greg KH <greg@kroah.com>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Martin Kaiser <martin@kaiser.cx>
Subject: Re: [PATCH v9 16/16] staging: r8188eu: remove usb_vendor_req_mutex
Message-ID: <YUxf5TD55Bf2v09v@kroah.com>
References: <20210921181834.29677-1-fmdefrancesco@gmail.com>
 <20210921181834.29677-17-fmdefrancesco@gmail.com>
 <dd99d40d-297e-8d27-dabe-d0e4c633d391@gmail.com>
 <4434c136-6bfc-9a25-d0ba-f989c655fa69@gmail.com>
 <dfa76ffe-2306-01b3-9746-c9aa43c03398@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfa76ffe-2306-01b3-9746-c9aa43c03398@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2021 at 01:12:53PM +0300, Pavel Skripkin wrote:
> On 9/23/21 11:47, Pavel Skripkin wrote:
> > On 9/22/21 16:21, Pavel Skripkin wrote:
> > > On 9/21/21 21:18, Fabio M. De Francesco wrote:
> > > > From: Pavel Skripkin <paskripkin@gmail.com>
> > > > 
> > > > This mutex was used to protect shared buffer for USB requests. Since
> > > > buffer was removed in previous patch we can remove this mutex as well.
> > > > 
> > > > Furthermore, because it was used to serialize the calls to the Core USB
> > > > API, we thoroughly tested the enabling of concurrent firing of USB requests
> > > > without the mutex and found no problems of any kind in common use cases.
> > > > 
> > > > Co-developed-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > > > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > > > Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
> > > 
> > > Hi, Greg!
> > > 
> > > If all is OK with previous 15 patches, please, do not take this one, it
> > >    causes problems with connection... :)
> > > 
> > > I don't understand what went wrong after v8, but anyway, this one should
> > > not be applied for now, since it's broken
> > > 
> > > 
> > > Thank you
> > > 
> > > 
> > 
> > 
> > Just to be clear: previous 15 patches _are_ tested and do not cause any
> > misbehavior or bugs.
> > 
> > I guess, the stack buffer maybe the problem here, since it's the only
> > change on this side since v8. I didn't have a chance to take a closer
> > look, but I will do it on weekends, I hope :)
> > 
> 
> Oh, I found the problem by just looking at the code with clear mind:
> 
> > -free_dvobj:
> > -	if (status != _SUCCESS && pdvobjpriv) {
> > +	if (pdvobjpriv) {
> >  		usb_set_intfdata(usb_intf, NULL);
> >  		kfree(pdvobjpriv);
> >  		pdvobjpriv = NULL;
> 
> This if should be deleted completely, because we don't want to fail on every
> probe :)
> 
> Sorry for noise... :(
> 
> Greg, can you take first 15 patches, if they look good and then I will send
> fixed version of 16? AFAIU, you are ok with taking part of the series

Please fix up and resend the whole series as our tools work best by
taking the whole thing.

That way I "know" you tested them all :)

thanks,

greg k-h

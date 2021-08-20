Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF2E83F2A71
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 12:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237182AbhHTLAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 07:00:19 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:37289 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229847AbhHTLAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 07:00:18 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id C1A773200368;
        Fri, 20 Aug 2021 06:59:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 20 Aug 2021 06:59:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=TaQBSg
        vqUCrWUfWtlGrPX2smT3iPxXowskDyFRH3cAQ=; b=YSE9v4z7Lssi/h0nmXQFhe
        vjePeecBql/ENblAUfx5fNEa0AuN3b1pvrereMbWvYn3s7zFXqPTUW0vCicZhExm
        /d0DXIBUct26XMrXO6b9cfEDAKUn06ceMxHO+MKAZqlw4hdfYQNaeIodrQbyWDo5
        hOExq9YWpt5TjDWrslqs4I1OYpzRqt7FEuqvUh705v3Oyfg56wN49wKzPosGDJN0
        Vk+sKFU32L7yNyRkzPSCaNySsB15/zCxbAbgGhO/2BLpa//IGN2yLFGqEhP+H9h+
        X6t8DyuDi6LpDClqGYKr0qAhw44lLP6GweE0zCORVIIFLwcAXARDhtd5s0V2Gr1w
        ==
X-ME-Sender: <xms:G4sfYbcGY2ugxOWYPazGWYfPc1U2kozBePJ2iYC-xeTczIkQfIs0Ag>
    <xme:G4sfYRNi3NtulCca5ZUfWbdQPjvw_HmNTVSdQp2qimSQHdQej7tNSNDM4ykIe3iw3
    nFgYo1g1bLObywXmfA>
X-ME-Received: <xmr:G4sfYUgs13f-tC9SJwpucCgk8SxOCTAxf-DCcXuscCCkZVZD0-xVL1gsPHrfCOm-8m5XyA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrleelgdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhuffvkfgjfhfogggtsehttdertd
    ertddvnecuhfhrohhmpefnuhhkvgculfhonhgvshcuoehluhhkvgeslhhjohhnvghsrdgu
    vghvqeenucggtffrrghtthgvrhhnpefgfeefudffhffgueehgeffffeggeevieefueethf
    eijefftedugfeuveethedtteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:G4sfYc_2qd_zJ1dEsR_4NpnaRIduKiLRCZGLyIPlctiUG0As7ChEog>
    <xmx:G4sfYXvUMzSx6dtxSjJ5WwI9g3Se4DHOmV7a4pP27jhOSBePb2tNqQ>
    <xmx:G4sfYbGWQtdZdm7RHp2nh1r16wUsQeZTypFjPSuszHD4jvk5jRyjlg>
    <xmx:HIsfYQVtdb1pdAuOHG6plDOjqn22mompa3cWc6PbLN87sHeGoPVz5w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Aug 2021 06:59:34 -0400 (EDT)
Date:   Fri, 20 Aug 2021 22:59:17 +1200
From:   Luke Jones <luke@ljones.dev>
Subject: Re: [PATCH v4 1/1] asus-wmi: Add support for custom fan curves
To:     Bastien Nocera <hadess@hadess.net>
Cc:     linux-kernel@vger.kernel.org, hdegoede@redhat.com,
        platform-driver-x86@vger.kernel.org
Message-Id: <T6X4YQ.G4UP78QP23941@ljones.dev>
In-Reply-To: <e7fbcf85f61b5c727a93df07b3bfe1624547067f.camel@hadess.net>
References: <20210820095726.14131-1-luke@ljones.dev>
        <20210820095726.14131-2-luke@ljones.dev>
        <321afe1a293be3a623a9be53feea3a008e044b31.camel@hadess.net>
        <L0W4YQ.ZVWQDLFJE8NR2@ljones.dev>
        <e7fbcf85f61b5c727a93df07b3bfe1624547067f.camel@hadess.net>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, Aug 20 2021 at 12:43:17 +0200, Bastien Nocera 
<hadess@hadess.net> wrote:
> On Fri, 2021-08-20 at 22:33 +1200, Luke Jones wrote:
>>  > Am I going to get bug reports from Asus users that will complain
>>  > that
>>  > power-profiles-daemon doesn't work correctly, where I will have to
>>  > wearily ask if they're using an Asus Rog laptop?
>> 
>>  No. Definitely not. The changes to fan curves per-profile need to be
>>  explicitly enabled and set. So a new user will be unaware that this
>>  control exists (until they look for it) and their laptop will behave
>>  exactly as default.
> 
> "The user will need to change the fan curves manually so will
> definitely remember to mention it in bug reports" is a very different
> thing to "the user can't change the fan curves to be nonsensical and
> mean opposite things".

I get the impression that if I add something in-kernel to disable 
platform_profile if curves are enabled we'll end up with a very similar 
situation regardless ("Why did platform_profile disappear?" or "Why is 
platform_profile not responding?").

There is minimal validity checking in the patch, such as ensuring the 
curve is either flat or trends up, never down.

> 
> I can assure you that I will eventually get bug reports from "power
> users" who break their setup and wonder why things don't work 
> properly,
> without ever mentioning the changes they made changes to the fan
> curves, or anything else they might have changed.

Yes I can imagine. I deal with this a lot in the asus-linux discord. No 
matter what I do to alleviate it, it happens - I've kind of taken it as 
a given now. This patch doesn't change the behaviour of 
platform_profile at all however.

If possible I'd very much like to continue with the current behaviour 
and see where it takes us.

Kind regards,
Luke.



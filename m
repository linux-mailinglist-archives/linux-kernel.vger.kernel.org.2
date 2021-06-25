Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E440E3B3C10
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 07:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbhFYFVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 01:21:14 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:60739 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230139AbhFYFVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 01:21:13 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id D161658059A;
        Fri, 25 Jun 2021 01:18:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 25 Jun 2021 01:18:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=UZD/VyZdsWSMg11/7IlDtFb+rfd
        /ChEceRSlzJvuiVg=; b=pcuFc/UY4mBK9U/Y2YkTjXNktERZZfxSj7jcIZecq1+
        yHjJv3eO2gdpGyQ2+mim3SC9wV9yfenhOBpcP2y1TLQ6efpa/Y93PVMN4kQHEeTW
        aCDp006d/Ay0XeP706r6wRTBbOppWF5nW1/ipDXjr7UstNLJ4WJI+O1giqFzlsbN
        L1pKJmWtg1t6wBrGqRybWYGG2rNaQwS8jh548qO4HFjDPzCY/eNZYKaeMo73nTqc
        NrTm5l3+1WXcHost7KB6WHSq4xxGhNk1ExnHfZFyjWV0xlcjlbUZ7sMdEkWDrhgK
        3Hgcms82cTtOC0rPNRcYOv4PtlrFsjeu+bA9/cZZOXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=UZD/Vy
        ZdsWSMg11/7IlDtFb+rfd/ChEceRSlzJvuiVg=; b=JSbMJXu+yUACrkn0SH9eys
        AC75aAgw3Py8kVJbnPoXDw2cp3wFigG5zVEtkOkxG9InUV+Jd/CNCKKv2Xd7ASvc
        q3S+afWrtYgv9mLBypPzgsfOYJYcmsGtKmCl6cMYqvUnK1/eI3wUiLebnnhyoWbq
        sZLHp6UnUvjeAVewthMNHv5RCU5ekPsENbMqPLqWzk8h2z6N/zeuacs8zzIrLU3n
        e2mZJ4iiYUiTqkR6sOBznsziHDUtZ1IQhMoFdoE+MfVsyRQOaA1Iln2/RdFWqYpe
        yBEhV7OOzGhMhOyeP4kddTmlGUw4NEhLEQypvCdPCMiOtnWmaEt7EWPtzJXbVflQ
        ==
X-ME-Sender: <xms:PGfVYAV16TyPGc9y3VK9dZtJfW2Wbv2lBzVNFKrLlS9Q6LeHo0MqcQ>
    <xme:PGfVYEltGy3f8ZH2w2_K0KtTxfNedFBC53BA1am_x5SH5X5e1aU8rv_bx9x0s1n3J
    n9epLr5DttbzQ>
X-ME-Received: <xmr:PGfVYEZ2id0tP31IGKrJIVVPmBP2ydBYeVQMsb_u6Oc_y9Ka8Rqh4gUz8VyRE1Vm3MdOn-8sZRXt79RYm4wJkfJ2Jngw9iKp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeegiedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeevueehje
    fgfffgiedvudekvdektdelleelgefhleejieeugeegveeuuddukedvteenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhh
    drtghomh
X-ME-Proxy: <xmx:PGfVYPWrNdU-Eby8YAZlzDD5JWLij0r4PzoUcpkVCgfCogUAin9Wcw>
    <xmx:PGfVYKkZeDgQDLrnCXVQ9ZZH5UHKoMuZphiHIDrw6XRnqvVGxePDeA>
    <xmx:PGfVYEdf46i32AJ9toq1LIfywAu3ns4uDJ5s5nJRspVzxlp9HiU2Xw>
    <xmx:PGfVYE3iqsdR3M-OakiUSfGl3QeT4YoBt0Mo2QOO_PXLxF06WGQ6tw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Jun 2021 01:18:51 -0400 (EDT)
Date:   Fri, 25 Jun 2021 07:18:48 +0200
From:   Greg KH <greg@kroah.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     "Liang, Kan" <kan.liang@linux.intel.com>, peterz@infradead.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org, eranian@google.com,
        namhyung@kernel.org, acme@kernel.org, jolsa@redhat.com
Subject: Re: [PATCH 2/7] perf: Create a symlink for a PMU
Message-ID: <YNVnOAdaxlJb0CcF@kroah.com>
References: <1624497729-158864-1-git-send-email-kan.liang@linux.intel.com>
 <1624497729-158864-3-git-send-email-kan.liang@linux.intel.com>
 <YNQckpOuw80uCUa1@kroah.com>
 <d25a0556-325f-9af0-a495-b9f222d63e10@linux.intel.com>
 <YNSWtCSjJy8CytOL@kroah.com>
 <1e536604-cf93-0f09-401e-2073924c5582@linux.intel.com>
 <YNSlVPcjHInk4un6@kroah.com>
 <33bccec9-c4c4-d52b-9ee4-9a09e7353812@linux.intel.com>
 <YNTCa5QO1YMy8fJ0@kroah.com>
 <1d77c148-7ea6-4631-d799-e8ec3d31f347@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d77c148-7ea6-4631-d799-e8ec3d31f347@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2021 at 10:49:42AM -0700, Andi Kleen wrote:
> Are you proposing to break every perf script on a kernel update? Doesn't
> seem acceptable to me.

I'm suggesting that you not submit kernel code that breaks the device
names of things that you previously stated would never change.

thanks,

greg k-h

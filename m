Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 082D235A41D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 18:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234185AbhDIQ4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 12:56:22 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:56585 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233896AbhDIQ4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 12:56:20 -0400
X-Greylist: delayed 351 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Apr 2021 12:56:20 EDT
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id EE6861924;
        Fri,  9 Apr 2021 12:50:12 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute3.internal (MEProxy); Fri, 09 Apr 2021 12:50:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm1; bh=I2ARre6sMlwVG8AO4ffutjQbbw3E
        mBEk5qjuhnkfh+Y=; b=z9rxDFp0oTlsSWd17C3tudQcxD8hvNIOUz8nWLhxFP0M
        OMTpLs1hQMz2uTzIRTHr/RWHv9M+/NQkHf6rXz4HJtgey+8/p3OmjBhl1aWfpVcO
        9iu021iIK12A3OAfRjaMXmYEjeTgKABqG2fW1jcfdOjhK+nq4YOKvQbF52TqwO5y
        OKVtRcTFw3aN0R5XRgLLmfSMrQP7lI3WgHKhr1J1F6X6FN3WnKz0G1R1YKkwRs40
        nrmkTtiuoKGxeBJ5Bh3ZP465qKVxvZxXp2u7hjedrR0FelvQG4UuOmXQxJ7QTTEd
        w/1KVsRxyhAtVJY/SuPG/qB8TOlzfiC1G16eddOlGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=I2ARre
        6sMlwVG8AO4ffutjQbbw3EmBEk5qjuhnkfh+Y=; b=b03f6ugp0gXJB7Ly6G51bd
        nR4nU03wq16kbLtA813Gale5AK2wz2lBIoS6p1mAFdfo7XqP6HWV8uOoyAyofgZ8
        eimFG25ADcw/HPqmpOkEhEFJuEEjO0MZ/cz0pitG/H3XoPMBxnrTc692r+CKQf7F
        DUnT+3JAlK/zT/F+QCmTEzDmS3pZ7C+s+xwuGZ0MFJ/nnLYwWN9OQZlRALskCrFC
        9IApcfxs+rwx7B/bSWu9UWGo24Os5pCpDivTlriqmNoA1sHXgPiYrfV6oCmWCAij
        qR18BzHDfXukOn3cIxFjNlUioBg1pOg1+ZOVN3IiON2LC7i2tsVWC77y0cBvGQMQ
        ==
X-ME-Sender: <xms:w4VwYHRlHHzwpvgwR7qsWHx6fWDGDTnkzHdMo8qOojRdJ1jvGdF8Xw>
    <xme:w4VwYIyGI8KdxgmjV2LCJabC53Z7V-_AWkwi58c4TD9Rz6XlmyvarZkszwQQzeHel
    LWV-XFBbpuosKkxj9E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudekuddguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedfufhv
    vghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrf
    grthhtvghrnhepgfeigeeiffeuhfettdejgfetjeetfeelfefgfefgvddvtdfghfffudeh
    vdefkeffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshhvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:w4VwYM1pcvx-UopNLhkBfzlGFZkwayv_YgFw7M9V9lqf1UEK406VxQ>
    <xmx:w4VwYHCmpNvJQKHMwyMLF_WiY9oo5R9Uw0W8vqTlkG7XCVudaPirbw>
    <xmx:w4VwYAhCJz4LwujvxcB-3-czvKN6xhHlAjWw4mlYkkrwEusrcHeGzA>
    <xmx:xIVwYKZM1rMFUGW9YZeMy6b34y1R1sHrmzLp_e9wUpm4eMkKYHLIgqOME2M>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 30C2751C005F; Fri,  9 Apr 2021 12:50:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-273-g8500d2492d-fm-20210323.002-g8500d249
Mime-Version: 1.0
Message-Id: <cc2a3f1f-da43-4767-b00b-6e88ecd3a05c@www.fastmail.com>
In-Reply-To: <alpine.DEB.2.22.394.2104041724340.2958@hadrien>
References: <alpine.DEB.2.22.394.2104041724340.2958@hadrien>
Date:   Fri, 09 Apr 2021 18:49:50 +0200
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Julia Lawall" <julia.lawall@inria.fr>
Cc:     "Marc Zyngier" <maz@kernel.org>, "Joerg Roedel" <joro@8bytes.org>,
        "Will Deacon" <will@kernel.org>,
        "Petr Mladek via iommu" <iommu@lists.linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kbuild-all@lists.01.org
Subject: Re: [PATCH] iommu: dart: fix call_kern.cocci warnings
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 4, 2021, at 17:26, Julia Lawall wrote:
> From: kernel test robot <lkp@intel.com>
> 
> Function apple_dart_attach_stream called on line 519 inside
> lock on line 509 but uses GFP_KERNEL

Thanks! Fixed for v3.


Best,


Sven

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4F036BE15
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 05:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbhD0EAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 00:00:30 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:34037 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229455AbhD0EA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 00:00:29 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 78E3E5C019E;
        Mon, 26 Apr 2021 23:59:46 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute3.internal (MEProxy); Mon, 26 Apr 2021 23:59:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=eZfNkGx2BMSMQ83oloGLPtdwxAJCowu
        oCAnvMoQdjj8=; b=bCVM03l4/97d497QZGfYgytoNBX+T1CreC0zTE0q6c0+9wZ
        mEGA4RTEYR+eTwIllHD5sJ3k1BsNcy4B7NDmvbtYqm+gd2nbsE+RU4/xD96BnD9j
        LGzCxHzTYCQQTk2NONoSTkzzIh+x8DwvuQ/xJ4wGTVkr0tjXi8CSwovp6oZXW7wm
        sk08hWJfC09ydM3Pwqf9YEIJP+qYDUvOUaNLXI4rnHvjrSDrwN1RHww1wH9ZxdWe
        R8OBPUy78pvC8TktsOLmV06fOIyQ7kyoK3BwjMNWKQ9Tmse9YVHQn9UcojbsHoa+
        6N40imzKpA6fk6x6jKdfgrbK0zcHpiyxKoDkmyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=eZfNkG
        x2BMSMQ83oloGLPtdwxAJCowuoCAnvMoQdjj8=; b=X0aOk0FLR+JJ2vqD5oDaKr
        Uritv7xfbgFrUCSGTg+8bCS+WsyTL0rMyPLn0u1IehKhwBRKFsNp4oGvthlkXj9/
        3afjivUZqn3NOVqvUL9o4BgmIQsx7OAdDx0z8He8SOux9HPnvBQHUsR6/w6C1Uv1
        pCVuWd+JB0wC4Y6dWvZtfHAP2SFgVzwlqkNN6QAvHU5m5rJj4ftfuo0+n9B2L1+N
        ez8Ts7Jt93j38xNFOotRSbbk869kTAesLvUiQOsVBuarMTieipjT7qGD1Vq1lMoB
        YIkf/u3+VVmnpE8xxZtQKrbTDJ0papDJYtZ/3GD9vcbORF9mJdoVLYVEHdLMmyxQ
        ==
X-ME-Sender: <xms:MIyHYLL89azaxFjwekkmWWjoOpLxc6CMprgVNyoDI2-YsdQmcd0dKA>
    <xme:MIyHYPKf0j0_tyVmd5aE9W-mXaJVVmM-xuD0VBMcSpCtl_Px32EoQXF354BbC8daP
    M0XJ36L0nrO6NTUnw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdduledguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehn
    ughrvgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucggtf
    frrghtthgvrhhnpeehhfefkefgkeduveehffehieehudejfeejveejfedugfefuedtuedv
    hefhveeuffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrnhgurhgvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:MIyHYDve2dQUlUboid9PDA4PTLOVOpqrsBANN4bmZnGbUYjbFAbx9Q>
    <xmx:MIyHYEYNtKviYmJndPX21uzTgIpm88701W5ffmOjJA8wwv9r3nhrgw>
    <xmx:MIyHYCZPYgw7pKFv6K6MIP8smjnu8oJ7lbaazwKspQpqRjadZ0MjXw>
    <xmx:MoyHYJzbJlkBhIZImGFb55oIa0jpv7oSRBAyowe0jM_AtAXkQ1yvyg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 07EF0A0007A; Mon, 26 Apr 2021 23:59:44 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-403-gbc3c488b23-fm-20210419.005-gbc3c488b
Mime-Version: 1.0
Message-Id: <201d989f-882f-4b73-ab06-5085f99301ed@www.fastmail.com>
In-Reply-To: <20210416075113.18047-1-zev@bewilderbeest.net>
References: <20210416075113.18047-1-zev@bewilderbeest.net>
Date:   Tue, 27 Apr 2021 13:29:22 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Zev Weiss" <zev@bewilderbeest.net>,
        "Joel Stanley" <joel@jms.id.au>
Cc:     openbmc@lists.ozlabs.org, "Rob Herring" <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: aspeed: update e3c246d4i vuart properties
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 16 Apr 2021, at 17:21, Zev Weiss wrote:
> This device-tree was merged with a provisional vuart IRQ-polarity
> property that was still under review and ended up taking a somewhat
> different form.  This patch updates it to match the final form of the
> new vuart properties, which additionally allow specifying the SIRQ
> number and LPC address.
> 
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

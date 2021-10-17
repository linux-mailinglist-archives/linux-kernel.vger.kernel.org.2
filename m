Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF55B430A48
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 17:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241164AbhJQPpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 11:45:13 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:57857 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237507AbhJQPpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 11:45:12 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id CA9EA58174D;
        Sun, 17 Oct 2021 11:43:01 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
  by compute1.internal (MEProxy); Sun, 17 Oct 2021 11:43:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm2; bh=Ar3UQU2Sa++4NZyb+2T9TqxUkLx7
        OwjH980XzmFd+HI=; b=az5eW2L/b1Av9aQt1pszh/6hgkWXcrHCeG8TF9+6S/gw
        zN7KBwORoKjoKJgeBNcokVCaG7fmtsYR+td/Vi0yDewtFnd99eSrXszwNkUoXlRr
        Auz0+uDg+K/R6+1X8deC9/C1nI8iioBPlwDAA5xm5QFRqMAiLXWQFm0itNnC6pRH
        GyE+AwiW7U2Ck7jmvGcWSzokmkZI2U4ekW2KR0xYe2Tuc4nNamE2TPNKeV3Wnx+x
        vI1mL73RIGJt0icWMjHPa2ieDmV+B1BDoR7KYOtDW2RugDpY4e0z/uALnOqkkAv2
        kWWxkl+8X6tB6IZ4IFnJlOBvbbYuyZjtinoycgOSmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=Ar3UQU
        2Sa++4NZyb+2T9TqxUkLx7OwjH980XzmFd+HI=; b=k5fZQ9y3A47yKYsHIwY61b
        IARHhWuUrxxFhvF9MwZqXioArgw+JC2vbA4cn7V/Pq5rpXqR2tZzYNU+Mn0XgCru
        R+H9WfVdzYF+0tJNJ/HoExyq+Fle+gFiKpuhTjJySLoV++VglowlULdWsRDbxHDm
        C5JsI0jWTn1X4/hhWc248uJxqDEj0VLKwdpZ/4+5UpcoKfFX1D97JWDanLce48r1
        jNYIgqlMMuHAuq1Lo7Hm92ujj5ZYtUjiN2rihrYSHohEVk9CIj1RhgCA84E6v6mk
        +jamEYLpqxk/i0qf6Tb08r4SWm9D5l2sEWqkRXSVWFjCDOKn2WTfPBqUb2PYmpdQ
        ==
X-ME-Sender: <xms:hURsYSul-wg9L0xU0Kz9anBBcoQfQF9dJoHuGmETSg8aKTvZV-o7iw>
    <xme:hURsYXcRJL98kKcS8gFEVhIRcia1ZeLCr8ex_DdD6wo-4z6HOm6GiWPg_XS0drKxb
    jJAKFyDWgQC20PU7Fg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddukedgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
    nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpeefieeiffekffetgeffleekgefgiedvgeffvedtleegieefhfejgeehleel
    hfeuveenucffohhmrghinhepuggvvhhitggvthhrvggvrdhorhhgpdhoiihlrggsshdroh
    hrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehs
    vhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:hURsYdyxIA1MCgEIvVNlNCwRy-3gL4p53vI9ZjbEMfUZYlBEqyChmQ>
    <xmx:hURsYdPOavpveBE_5aILJN8MJR7V2i_zkRp_g5rVqav7T6lEPWFUbQ>
    <xmx:hURsYS9mE3aRQrYnH9zyUgbOf6154c8DE5X6xVue_D4ZP1-ii40_ag>
    <xmx:hURsYVZKbV-TS6VXlMirLhWddRvgTZA9C-C4mZugrfbjoh6x3Cse2A>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 1C0932740061; Sun, 17 Oct 2021 11:43:01 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1345-g8441cd7852-fm-20211006.001-g8441cd78
Mime-Version: 1.0
Message-Id: <8a64dc78-4c8d-4eb2-b6e4-d0470f3eb511@www.fastmail.com>
In-Reply-To: <1634484570.833028.60701.nullmailer@robh.at.kernel.org>
References: <20211017114054.67737-1-sven@svenpeter.dev>
 <20211017114054.67737-2-sven@svenpeter.dev>
 <1634484570.833028.60701.nullmailer@robh.at.kernel.org>
Date:   Sun, 17 Oct 2021 17:42:40 +0200
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Rob Herring" <robh@kernel.org>
Cc:     "Jassi Brar" <jassisinghbrar@gmail.com>,
        "Mohamed Mediouni" <mohamed.mediouni@caramail.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Hector Martin" <marcan@marcan.st>, linux-kernel@vger.kernel.org,
        "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
        "Mark Kettenis" <kettenis@openbsd.org>,
        "Stan Skowronek" <stan@corellium.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "Mark Kettenis" <mark.kettenis@xs4all.nl>
Subject: Re: [PATCH v3 1/2] dt-bindings: mailbox: Add Apple mailbox bindings
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 17, 2021, at 17:29, Rob Herring wrote:
> On Sun, 17 Oct 2021 13:40:53 +0200, Sven Peter wrote:
>> Apple mailbox controller are found on the M1 and are used for
>> communication with various co-processors.
>> 
>> Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
>> Reviewed-by: Mark Kettenis <kettenis@openbsd.org>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> Signed-off-by: Sven Peter <sven@svenpeter.dev>
>> ---
>>  .../bindings/mailbox/apple,mailbox.yaml       | 79 +++++++++++++++++++
>>  MAINTAINERS                                   |  1 +
>>  2 files changed, 80 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
>> 
>
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml: 
> properties:interrupts: 'oneOf' conditional failed, one must be fixed:
> 	[{'description': 'send fifo is empty interrupt'}, {'description': 
> 'send fifo is not empty interrupt'}, {'description': 'receive fifo is 
> empty interrupt'}, {'description': 'receive fifo is not empty 
> interrupt'}] is too long
> 	[{'description': 'send fifo is empty interrupt'}, {'description': 
> 'send fifo is not empty interrupt'}, {'description': 'receive fifo is 
> empty interrupt'}, {'description': 'receive fifo is not empty 
> interrupt'}] is too short
> 	False schema does not allow 4
> 	1 was expected
> 	4 is greater than the maximum of 2
> 	4 is greater than the maximum of 3
> 	hint: "minItems" is only needed if less than the "items" list length
> 	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml: 
> properties:interrupt-names: 'oneOf' conditional failed, one must be 
> fixed:
> 	[{'const': 'send-empty'}, {'const': 'send-not-empty'}, {'const': 
> 'recv-empty'}, {'const': 'recv-not-empty'}] is too long
> 	[{'const': 'send-empty'}, {'const': 'send-not-empty'}, {'const': 
> 'recv-empty'}, {'const': 'recv-not-empty'}] is too short
> 	False schema does not allow 4
> 	1 was expected
> 	4 is greater than the maximum of 2
> 	4 is greater than the maximum of 3
> 	hint: "minItems" is only needed if less than the "items" list length
> 	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml: 
> ignoring, error in schema: properties: interrupts
> warning: no schema found in file: 
> ./Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
> Documentation/devicetree/bindings/mailbox/apple,mailbox.example.dt.yaml:0:0: 
> /example-0/mailbox@77408000: failed to match any schema with 
> compatible: ['apple,t8103-asc-mailbox']
>
> doc reference errors (make refcheckdocs):
>
> See https://patchwork.ozlabs.org/patch/1542209
>
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>
> pip3 install dtschema --upgrade
>
> Please check and re-submit.


Whoops, looks like this fails some new check added since I submitted
the last version a month ago.
I'll drop the "minItems: 4" since the number of items is constant anyway.


Sven

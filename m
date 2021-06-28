Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32A9A3B594D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 08:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbhF1G6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 02:58:02 -0400
Received: from wnew1-smtp.messagingengine.com ([64.147.123.26]:37353 "EHLO
        wnew1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229998AbhF1G57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 02:57:59 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 11F982B00A29;
        Mon, 28 Jun 2021 02:55:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 28 Jun 2021 02:55:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm1; bh=W
        0b8I7MW5oHpL7ipkRpkxZLHoV17rO9ZRR9rsaHOszQ=; b=QhDCkGmM/A6CGbwsT
        /qhliCAlEY9K+olYXIySoB2hzUy4BVx4jd9NK7ucWBhbtGpt2ASap4ZlAymeuYn2
        N5jmyoebD2IaIX86nTZYBtI4CvG/3Pxj+V32pFIL6iVvYZHhIU2HWW7aL+SuG2qb
        yMMbtGLMilm0X4n83eFykiFZ/u2LRvc4iImYH0R91Vr3Qhyz33aRBftDCJ6X4PAP
        +i7HWOYsuscr1AY7pKmdHBPxWcnCJym+6sw4Q+EudhrO5j2yoQy31KgexXg2k9fJ
        Q5dn4OCAPSAP32+v6l5OTC6OBc5596sVIuZpqhxqMwikENl6fCh4vOdSHz4Ql3En
        dtXAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=W0b8I7MW5oHpL7ipkRpkxZLHoV17rO9ZRR9rsaHOs
        zQ=; b=nxjsoytoYqBDALMbDhnSQ+UhTEcg1/6fB6pTHIwWHA4gKaNzdBKd1I0iF
        9lAwUDtxYPueCMCXIIe4eJxnX6ouCQ6q0WyfiKW/10ezyLTUQELy3aa/PMJVTsbw
        fx/MMthAsOcUCWCV+8kd/zcTCjc6WntRtIlohhGbn5htoX0iM0pGChye3EyK1ju4
        QamyUhsgLZ45L6FxF6QzAd24fAZVrn/l0od8PAOmpZNAVlpvhzUeBFGJZGc3atUj
        xCKIfmwH+JhgJHbJGhxYd1pILRiTjXRlQwC/sioXxFf7uePX1vyMKds6xC5yTCGU
        1QMjebaaHsmjlujBStUZAXPTw19lA==
X-ME-Sender: <xms:Y3LZYPSqXm_2XRi96-XXaZp_XZccp7FVKQtUt40j85TJ_hxXCxKMww>
    <xme:Y3LZYAwezPGtxfF3NvhkV0nvE6XxwQ4f7dy0K7EHQg1-Wvurv9-KzqJauJGnSOHUY
    -Oq1kGxvwj6Yw>
X-ME-Received: <xmr:Y3LZYE3rV2nNUfs2jlWENJoGFJH0ylUnHf9ECBCjFvNd__TXHfljQ_Bq0hfiJR-GeahLV4pp_FYZYTq-HDhwPAQWaH4uI1Zk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeehfedguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggugfgjsehtkeertddttddunecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeevtd
    eileeuteeggefgueefhfevgfdttefgtefgtddvgeejheeiuddvtdekffehffenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhroh
    grhhdrtghomh
X-ME-Proxy: <xmx:Y3LZYPDJtc1PFrQvwg_iuiFRvUvUF5skfkerhNg54bTRUz_n045JJA>
    <xmx:Y3LZYIhfWG_4GsnCSM-IPG_C04wHB0m0q-0h8hsLGomXhpPdztQuzA>
    <xmx:Y3LZYDp5u1Aor-Ca44ImIPX4bhpnzmVxrG-oKZWUtp8-lHyNjcA35A>
    <xmx:Y3LZYPTYX544XC4ESXjI5s-JZM4oTubpa2CISRB3q8yQTC8j06krpyZ3zVA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Jun 2021 02:55:30 -0400 (EDT)
Date:   Mon, 28 Jun 2021 08:55:28 +0200
From:   Greg KH <greg@kroah.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     kan.liang@linux.intel.com, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, eranian@google.com,
        namhyung@kernel.org, acme@kernel.org, jolsa@redhat.com
Subject: Re: [PATCH 2/7] perf: Create a symlink for a PMU
Message-ID: <YNlyYJIl5yki0Q+3@kroah.com>
References: <YNSWtCSjJy8CytOL@kroah.com>
 <1e536604-cf93-0f09-401e-2073924c5582@linux.intel.com>
 <YNSlVPcjHInk4un6@kroah.com>
 <29d5f315-578f-103c-9523-ae890e29c7e7@linux.intel.com>
 <YNVneO6exCS4ETRt@kroah.com>
 <540d8a38-da12-56c8-8306-8d3d61ae1d6b@linux.intel.com>
 <YNXqXwq1+o09eHox@kroah.com>
 <e670abe2-67b9-a602-410a-0c4170796ec7@linux.intel.com>
 <YNhauAgaUxMfTa+c@kroah.com>
 <bdeb80ea-99dd-d9ea-d508-9cb8d2c6fbf4@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bdeb80ea-99dd-d9ea-d508-9cb8d2c6fbf4@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 27, 2021 at 09:30:53AM -0700, Andi Kleen wrote:
> 
> > Then do not break things by renaming the device name, as you all have
> > now stated that this name is part of the user/kernel api.
> 
> The renaming comes from the fallback mode on future systems. In the fallback
> mode the driver doesn't know the true name, so it has to use  the numeric
> name. If you don't use the fallback mode and have the full driver then yes
> you'll get the same names as always (or at least as they make sense for the
> hardware).
> 
> But we would like to have the fallback mode too to allow more people use
> uncore monitoring, and that's where the need to for the second name comes
> in.

So then just always use the "fallback" name if that is going to be the
name you have for this hardware device.  Why would you want it to be
renamed later on to a "fancier" name if there is only going to be
one-per-chipset-type anyway?

Naming is hard, make it simple and do not change it if your userspace
tools are not going to be able to handle the issue.  Do NOT paper over
your naming scheme with symlinks from the very beginning, as that shows
the naming scheme is flawed.

thanks,

greg k-h

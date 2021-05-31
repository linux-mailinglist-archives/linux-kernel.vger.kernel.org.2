Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAC433969B2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 00:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232340AbhEaWmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 18:42:24 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:56383 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231717AbhEaWmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 18:42:20 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 01E7B5C0212;
        Mon, 31 May 2021 18:40:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 31 May 2021 18:40:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        hubert-humphrey.com; h=date:from:to:cc:subject:in-reply-to
        :message-id:references:mime-version:content-type; s=fm1; bh=ZM9N
        JCYpaW6+eEOodHIhB4qC337WAJ7EJiOuKIG2PhA=; b=Etcq1ZbybmCqGacmiEc0
        emL+vlaISgZVejUl5Yg8ei3+n7OZgxHaJLvQteOpyOeSQjXbb/Npc92s22ZuUusV
        +DaKrwXZevnC8834fLJPVn6wQDOzEq3uAyCbM4Nd+IxydkWh3NtvQtp6ZQ8Pc204
        To2+KgxHZ4f7GzkiQvEI18XDIlKpmmPiwVSJftX6EZ58n5XxM9UFT9oX3wbSHduh
        Kg29PN4eFdieEW739t+krUzSqfqV7PCTJL6Hsa5tJbjmGRFilD7+kAkdXMvxUEpt
        6qd6lu6txevoKBSjAgY5qZL8w7ZTt0maGlFwdhBjEUxbHYKo8LF7fccOaEF1xXFf
        tA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=ZM9NJC
        YpaW6+eEOodHIhB4qC337WAJ7EJiOuKIG2PhA=; b=TuME0PoZz3ko+kqmfX0BcJ
        DFdp0srVirpwtSQQBkUfKn24i7+3Il1ejXUK60S4ZmCAnFqXutowa4o4K5lma0AM
        3Q73jtR5p21RDrRK6Phwg/kZtQkbSOJ+FQU/O+3hmEJhR2Zmo1ajUUAcM33fK7/+
        AQmIT+8Nuo9NapW7QQ7l3PtjX+XpIPJvrXGubnl+R94jf4ydBCrwC6eucoS1+uq2
        gJHMbvpqqU9HKJEFt5h1bsH+NCNtbnSWuLD8ou2x88T6r5dCeLORWa234cme3bhQ
        lzwXc+TvsG/cSC4vk03hjbMRJsek6sQxv836d5/fAvZtaqZogIdjLodAH0+4+fdQ
        ==
X-ME-Sender: <xms:52W1YHxdlup7JTlVbdbRDW438j2r3sXQqITMaxaL605MkwokiXzrrA>
    <xme:52W1YPRRSfiwNAtCzQlYbgb_uCWCb0o_sATetTYYj8rlXYyA_Lj7gkCaOQhqlQPnF
    uNfqRewNXkaEg_G4sE>
X-ME-Received: <xmr:52W1YBV1KbOjB_uTlUgjU6-0m7u1oUPxIv5lJYWN3BOh3PkX60iOlMfyyOUoHzeEDgM5GkU6PT9j9oanLYH_5ybCgg1U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdelgedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffujgfkfhggtgesthdtredttddtvdenucfhrhhomhepvehhihhmvgcu
    jfgrrhhtuceotghhihhmvgeshhhusggvrhhtqdhhuhhmphhhrhgvhidrtghomheqnecugg
    ftrfgrthhtvghrnhepffehtdfhvddvueeuieehvdefffeutdegueduhffgleetledvuddu
    gfelkeevtdevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheptghhihhmvgeshhhusggvrhhtqdhhuhhmphhhrhgvhidrtghomh
X-ME-Proxy: <xmx:52W1YBgkF_LcFickNOvQdfKE752kpE2aJ6LDFusChqX_4CxbKdC8JA>
    <xmx:52W1YJCyqzCMf-6q1JRLMRQydHrY7LfZomrW1P237bI3R154OSmIgw>
    <xmx:52W1YKIDL_lNrm-6YGd-45u-x-9BxUvzkap-4QdFAl7TbQ6eZj41ng>
    <xmx:52W1YDBBOzJuo49xLys53g9zxRfnVigVAjBdg0GWAmKdxY-9zhQAYw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 May 2021 18:40:38 -0400 (EDT)
Date:   Mon, 31 May 2021 15:40:36 -0700 (PDT)
From:   Chime Hart <chime@hubert-humphrey.com>
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>
cc:     Igor Matheus Andrade Torrente <igormtorrente@gmail.com>,
        speakup@linux-speakup.org, corbet@lwn.net,
        gregkh@linuxfoundation.org, grandmaster@al2klimov.de,
        rdunlap@infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: docs: Convert the Speakup guide to rst
In-Reply-To: <20210531220754.h4ep2dj65wl6hejf@begin>
Message-ID: <ac51e981-961-31c8-29b9-64c4ad88df42@hubert-humphrey.com>
References: <20210531215737.8431-1-igormtorrente@gmail.com> <20210531220754.h4ep2dj65wl6hejf@begin>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Samuel: While I've never heard of that file extention, I sampled that file, 
heard nothing unusual, probably reading in Alpine.
Chime


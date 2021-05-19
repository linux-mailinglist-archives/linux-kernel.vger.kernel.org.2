Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B53653887D2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 08:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238101AbhESGyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 02:54:23 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:46169 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237977AbhESGyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 02:54:21 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 3030A580B64;
        Wed, 19 May 2021 02:53:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 19 May 2021 02:53:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=kTBrne82hFb800r6m31zRlpp/yf
        f/35hsrQ9fv4qhfI=; b=bwpjinttTCYdm4FfeFvZtXaTMUbwwfpmJIiWpVttH6G
        fz9++jDEXuLLveDnRZQdeekQ0ymP2VCbAQx1U9Cnm/7lm1e0t3sewTkJlf6bxzNx
        4Cza1MVV2gXyQ+P2ttkTLDcaAA7UiFC3wSczYAn7EGY6/3riOcQZmrGHkPYQ6aNz
        vWDeH5+RaQEvLlAip3f5x1zhbuiJbNGB0J4+N7sfI/qpmApSKSBv1YAAglFaWQDP
        l3efAo+BDDNenWDf7ypERf6K5myt28k2R3MVwCXuQam4y/Bm5QoXE1uPm/+fWq13
        ALdrU4BAE6Mlw4BL0gLMBYxc78cLZvwja8xfS/rBRhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=kTBrne
        82hFb800r6m31zRlpp/yff/35hsrQ9fv4qhfI=; b=olA4F3iMUj1kyDQ2nLjMIp
        nt2ly2GUzX9uCDAqxeqZDVM+D5hR7OzjNPjSJa7Z4ouhBlmMa8EnAgQ300giS5dF
        mACohN6ububgNvkEEasBwZmX2fOQBJAjmTQXHaH2YeTLAAUMCwaT8lucN2I136j6
        vqrRZpItgFB15AFYzMzswDYKnty8XoqsfjoQrRChno8xEEVjd+9v3F05/S6YHZhP
        hjiXPQSxuiqwz44bAa28l16kVb+/lyjEQmgADq3rK8NXi9cxCqacZrZ4aYwieu51
        TOPOUvAYJYxfsJJt3TPKuxddp5o9ujGLjvl3zoYONIvNlShxs6AFY0mz3FAHi2wA
        ==
X-ME-Sender: <xms:zbWkYDhCJyE_zJAJ12yiuD_W3ZeTQHptzGXks_g1gBhFiROZRNBqeA>
    <xme:zbWkYACey0ZqygTXGy2GXsUi3-ltDhC6csB7I9KQfmYrQkA2zjv8o6qhMeNPsMAFM
    AxLk9mZ6zNN7w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdeikedguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepveeuhe
    ejgfffgfeivddukedvkedtleelleeghfeljeeiueeggeevueduudekvdetnecukfhppeek
    fedrkeeirdejgedrieegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:zbWkYDGeBrSVaImkmT2m1lMIzvIOkxXRcrZZYt6M7AAcI6exeyaEbQ>
    <xmx:zbWkYATNADEf4gwpnkEE_ZpvKJgAZKqfJucMg3wmGbvB6WuIZqkj7A>
    <xmx:zbWkYAynfElLx_WN1mqqIsZwoRFv-EzxVGj8umsBgIJ6AnfG6lrZ1g>
    <xmx:zrWkYMD_dDPrFGKqxnEFzz8rziWjqOY5Y3hUlYYSDIb-SeGp_6c98w>
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Wed, 19 May 2021 02:53:01 -0400 (EDT)
Date:   Wed, 19 May 2021 08:52:59 +0200
From:   Greg KH <greg@kroah.com>
To:     Crag Wang <crag0715@gmail.com>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        mario.limonciello@outlook.com, crag.wang@dell.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] thunderbolt: add support for authenticate on
 disconnect for new dock
Message-ID: <YKS1y3UNnXeslWd+@kroah.com>
References: <crag.wang@dell.com>
 <20210519064146.58454-1-crag.wang@dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519064146.58454-1-crag.wang@dell.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 02:41:46PM +0800, Crag Wang wrote:
> Signed-off-by: Crag Wang <crag.wang@dell.com>
> ---

I can't take patches without any changelog text, sorry.

greg k-h

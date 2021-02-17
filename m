Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D56531DCFB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 17:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234043AbhBQQLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 11:11:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:56166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233940AbhBQQLN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 11:11:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0A09464D73;
        Wed, 17 Feb 2021 16:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613578233;
        bh=zlJnX80plK5gq1lT6dj1D+MuToPiw+La1pmueuNMZy8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lIAIDV0kmgW0zYntwst5sgUsToylHeGwZBJixqiRvgDEZthrxPQUexCMZNyXfxhF+
         hPWgtt8RM8R1ly1rJQuWKWvEEphrZJdVhzGXswiFRVTb5LuBUp7vbjCS8KY6CIVK5c
         f/H3PgyiztWTKSHuhcZ5QDGb/4jJIiYGIEGB+eEXtAKlBX0xGE7NdFusyqf+w2dZNC
         uFMgBFM3zph6ICp7Q3XMVUehS+0vbnvTQKqC0wTBN3NZcNc4z6OasQZ0Px3O/mC4kS
         27anDqQuunYco4e/wVYJUaWYUdK6+2JrdlC7bF5s+VVKfZnQ5BVu7vr/uYuxMA1hu7
         ED8quTnJWGWkw==
Date:   Wed, 17 Feb 2021 17:10:29 +0100
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Rui Salvaterra <rsalvaterra@gmail.com>, gregory.clement@bootlin.com
Cc:     andrew@lunn.ch, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: turris-omnia: fix hardware buffer management
Message-ID: <20210217171029.40922d14@kernel.org>
In-Reply-To: <20210217153038.1068170-1-rsalvaterra@gmail.com>
References: <20210217153038.1068170-1-rsalvaterra@gmail.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rui, in the future make the subject prefix
  [PATCH mvebu-dt]
or
  [PATCH mvebu/dt]

so that Gregory knows its for him and for which branch.

Marek

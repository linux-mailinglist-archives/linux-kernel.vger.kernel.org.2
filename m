Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12D9131DC96
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 16:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbhBQPnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 10:43:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:52936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233476AbhBQPnR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 10:43:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2A92364DE0;
        Wed, 17 Feb 2021 15:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613576556;
        bh=TsRYdKmcgIcJeD9Rxfij6XeL5DVRBITf0FR0jdJTYzQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eohf6q++f0NJZN7Pq+D3NhZBWxVxkydi9/WrHPHx00Ppnaf7pcUgCL3j2DG301l28
         m+e+uwesNElrIC0wjmhLjJXvXxQOLsokWSd47ZjP/EMTSr8HBVULxd0r1ZIB2ioAPX
         5oYb/UQ2uWD/9wQcnQKdY6+SaPHLf6EnOaWhjSB/06rGWVKcTDMjfz+huS+rzGLMGa
         IlIdY2jwSv026851TIhlo54sUoV0w4j2mqzNTPL0jFuoINAykHtWjgFVmrUfNu50bA
         xVWwQcupXWRdfZ0t5B11J/0+uk6U+//6QvLeZN2DkABi91V/HAEVZtDK2/jX5WFRf0
         SWLpvvMlUL+Dg==
Date:   Wed, 17 Feb 2021 16:42:32 +0100
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Rui Salvaterra <rsalvaterra@gmail.com>
Cc:     andrew@lunn.ch, gregory.clement@bootlin.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: turris-omnia: fix hardware buffer management
Message-ID: <20210217164232.25a7765c@kernel.org>
In-Reply-To: <20210217153038.1068170-1-rsalvaterra@gmail.com>
References: <20210217153038.1068170-1-rsalvaterra@gmail.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

/o\ How did I manage to miss this?

Please wait a few minutes I am just going to do a fast compile and test.

Marek

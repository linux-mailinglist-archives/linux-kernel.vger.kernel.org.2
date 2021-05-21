Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51A5638C35D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 11:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236615AbhEUJkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 05:40:07 -0400
Received: from muru.com ([72.249.23.125]:58448 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229457AbhEUJkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 05:40:05 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 2BA2080C0;
        Fri, 21 May 2021 09:38:47 +0000 (UTC)
Date:   Fri, 21 May 2021 12:38:39 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Dario Binacchi <dariobin@libero.it>
Cc:     linux-kernel@vger.kernel.org,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: osd3358-sm-red: group in the same phandle all
 its properties
Message-ID: <YKd/n2AAy+OFe4Bp@atomide.com>
References: <20210428164026.17850-1-dariobin@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210428164026.17850-1-dariobin@libero.it>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Dario Binacchi <dariobin@libero.it> [210428 19:40]:
> Having a single phandle reference for rtc0, mmc0 and am335x_pinmux makes
> the DTS well-ordered and therefore more readable.

Applying into omap-for-v5.14/dt thanks.

Tony

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8FB43B57B6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 05:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbhF1DI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 23:08:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:32896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232048AbhF1DIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 23:08:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9CB9C61984;
        Mon, 28 Jun 2021 03:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624849557;
        bh=xCB44V1uyYWZwT6bHfs4PvePM7eeMvq6bga7ptvGQIA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=McZAe9/ANghqpPvD/ssRFNcgm/Dli9BswAtpuDzbeHmMPtzymVMT+NtgMNhvBsI18
         fk+nvOhExr/n244aarci2vhIp1+anCuES+JP/mxSLVIMkNG2O61IjwdGA7Hrnu1vuQ
         7e/dm4/0lb833+POTpsxF5eU/M9GZuVD+PYO7hxdEMvfoPgEwDIorY2QKqTZO0wIOg
         HnGH/tPrCtZmVJAtD/MlS3Dm0t1VtRfdxYelWPiUphgh47btI5MyechdVKgG+RK0Ef
         a16CLhT53Eo8RyYfB3ny9JvDoHpXio8yaYdHf42nem4nuVeN0gZTHsWuq6h2BMZLwp
         yg5+8dEAfxhrg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1616498973-47067-2-git-send-email-gengdongjiu1@gmail.com>
References: <1616498973-47067-1-git-send-email-gengdongjiu1@gmail.com> <1616498973-47067-2-git-send-email-gengdongjiu1@gmail.com>
Subject: Re: [PATCH v8 1/2] dt-bindings: Document the hi3559a clock bindings
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Dongjiu Geng <gengdongjiu@huawei.com>
To:     devicetree@vger.kernel.org, gengdongjiu1@gmail.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, robh+dt@kernel.org
Date:   Sun, 27 Jun 2021 20:05:56 -0700
Message-ID: <162484955636.2516444.15491190590642281998@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dongjiu Geng (2021-03-23 04:29:32)
> From: Dongjiu Geng <gengdongjiu@huawei.com>
>=20
> Add DT bindings documentation for hi3559a SoC clock.
>=20
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---

Applied to clk-next

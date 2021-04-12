Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3157635D1F3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 22:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238327AbhDLU0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 16:26:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:46358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237251AbhDLU0G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 16:26:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6E5FC61352;
        Mon, 12 Apr 2021 20:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618259147;
        bh=r9UKdIFOgp7BUaHYAHhj7B4vhiYePgsCQ4+XN5Emsd4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=AYOwAoNutSyEqKl/2oZRcdM3qcas7yBRs2LDYEwXIM1B/XVxzEl710EIpG4BJL07Q
         1ifr2J6YaQnGYpAXvTakowZHoxrqrGofbVULEDDEA1Zw3JpwTS69a33HxXjrC4JU4x
         jCiFPin/JuJjKnVCLBfaWMI9kcdGVshDDFvc4Q6MDPQNQYjmPskTjauto+klyqj87V
         9HLCjUvaW3V7CXhRXaggpGYwOzrAFsQcTffpcGt/0jfr9QqgtVb8wR8rZtwg9hvEY9
         rC9mU/TBKWlojN3qhx9uYtXE7U6hJA7xWpXHUW00J5qg2cu04dOI6149IJM/gdkCMM
         Adz/rWlUZEWzA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210410111356.467340-2-jbrunet@baylibre.com>
References: <20210410111356.467340-1-jbrunet@baylibre.com> <20210410111356.467340-2-jbrunet@baylibre.com>
Subject: Re: [PATCH 1/5] ASoC: stm32: properly get clk from the provider
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Date:   Mon, 12 Apr 2021 13:25:45 -0700
Message-ID: <161825914594.3764895.14268186433795123078@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jerome Brunet (2021-04-10 04:13:52)
> Instead of using the clk embedded in the clk_hw (which is meant to go
> away), a clock provider which need to interact with its own clock should
> request clk reference through the clock provider API.
>=20
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

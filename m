Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD153B5686
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 03:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbhF1BNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 21:13:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:35548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231882AbhF1BNa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 21:13:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 76FED61469;
        Mon, 28 Jun 2021 01:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624842665;
        bh=4U8IAKyf+nfJFUagq67MN8/R+vxrNYFsxhRbesRmJe0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=PNhXXyu6uxAOqvbEQydZ1kX2kjjK+ceZftAF06hIUdlRRUc0K8xaPdJegNgwlh7q5
         adhvVBsapcmQOIY2vjv0IwNWw5OmvBiLkkZA0WmW9bbJ0ja3EyLadHQO2kUY9hei8d
         5VN+nVtjA/t6YurX20bclVNtgQ0LMR1zokB9OtJ4wQiXKMr2fP8SiTR5H6qCoaXLLJ
         3lCkS0iDzmgq+dKgR130gWElxuBAVXat4d6G3xzvSw5AfXwf4Th4WE+f/X03ltDGeU
         m5jLS+FQk7r+FZjonSc28VjQwDG44l3ho8Hs+0pvDJ5LeKGksqxlDpT0jgyKoYNuCn
         qLUcLCdiqBNUg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210423004057.283926-4-liambeguin@gmail.com>
References: <20210423004057.283926-1-liambeguin@gmail.com> <20210423004057.283926-4-liambeguin@gmail.com>
Subject: Re: [PATCH v5 3/3] dt-bindings: clock: add ti,lmk04832 bindings
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     julia.lawall@inria.fr, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org
To:     liambeguin@gmail.com, mturquette@baylibre.com
Date:   Sun, 27 Jun 2021 18:11:04 -0700
Message-ID: <162484266430.3259633.17852417675846434232@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Liam Beguin (2021-04-22 17:40:57)
> From: Liam Beguin <lvb@xiphos.com>
>=20
> Document devicetree bindings for Texas Instruments' LMK04832.
> The LMK04208 is a high performance clock conditioner with superior clock
> jitter cleaning, generation, and distribution with JEDEC JESD204B
> support.
>=20
> Signed-off-by: Liam Beguin <lvb@xiphos.com>
> ---

Applied to clk-next

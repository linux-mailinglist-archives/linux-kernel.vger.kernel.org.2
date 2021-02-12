Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7C5C31A6AD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 22:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbhBLVTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 16:19:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:59972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231175AbhBLVSx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 16:18:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0CD9D64DA1;
        Fri, 12 Feb 2021 21:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613164693;
        bh=4TFSTvj6ttdPFslO5+a0fodyQQ+7J57hi9zacbZWyJs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=u2vcnA/DOj+ItizXjVG5627+qp5r2GJa6v4FcbNYyT2u0oU7GwjstZImCDltbyvdT
         a0N23oq3n7v5d52OtGjnpA1yEx2w7gJm5uLRL3PDpiw76Vq4Ldk03vuXF29qqlcvrq
         GtXCJxGQ8h2W2HZTlP+SEQ+85bsehw/wHkhdksUpOjzWrgAC6S4EB2DyUgqlWNptXu
         RFtid48EMVEMX680zZZ1evLQY+oJ06vonq47DzjsjL3x5L/XrRsv5wYEHhnk6jX8JH
         PMDOhuVobQXOb9Yb0IqiUaCsftkDDVQ068HxlFDvOfICIzZbY+DX8WQaifXk+r9G0E
         opbRiVxdHcZ7g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210212143059.478554-1-dinguyen@kernel.org>
References: <20210212143059.478554-1-dinguyen@kernel.org>
Subject: Re: [PATCHv1 1/2] dt-bindings: documentation: add clock bindings information for eASIC N5X
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     dinguyen@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Dinh Nguyen <dinguyen@kernel.org>
Date:   Fri, 12 Feb 2021 13:18:11 -0800
Message-ID: <161316469175.1254594.17867254186604019043@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dinh Nguyen (2021-02-12 06:30:58)
> Document the Agilex clock bindings, and add the clock header file. The
> clock header is an enumeration of all the different clocks on the eASIC
> N5X platform.
>=20
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---

Applied to clk-next

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A92534F6D3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 04:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233539AbhCaCeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 22:34:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:58492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233633AbhCaCeK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 22:34:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D64D0619BB;
        Wed, 31 Mar 2021 02:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617158049;
        bh=P1ycCaJRtdTw/ez3I1U4IXmZ4dBfUAPvRerdfcoqC+U=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=laS3cyhbq2vDgu7+lt+mPI1EJXXLr04Rb0MtT/+83yNTxhNugSCfLVFvLpg4IE4x4
         KQR4YQ3xLpa/4aQwIa2+lE6wXkaituRuPMsXdH5Kti+nZ8ANFbd2wmh+1Dv5cxCZnu
         vuaWtIxP87Y0lGBiMFZzs7LyGZG5lyqFl3fMaBKOQULYB8bKL3BMpfnY+ZfYbK5lwR
         jHvCHUDhtwKbfXBGcbrjx+bT1WL/EF7Zjh6oxEtL34mMVNmrpTmEl6ohsihijSRb8N
         zm4GF9dXGo1DeHDIvFsuVQoLZoJuFcVaNTNz9jI6V9NgyCjWeyPplLYimxipNArqcY
         /aQ9cYjkPUY6w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210331023119.3294893-1-sboyd@kernel.org>
References: <20210331023119.3294893-1-sboyd@kernel.org>
Subject: Re: [PATCH] clk: socfpga: Fix code formatting
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Dinh Nguyen <dinguyen@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Date:   Tue, 30 Mar 2021 19:34:08 -0700
Message-ID: <161715804871.2260335.17275038281861049092@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2021-03-30 19:31:19)
> This function's parameters are oddly formatted. Looks like a newline was
> missed or something. Fix it.
>=20
> Cc: Dinh Nguyen <dinguyen@kernel.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next

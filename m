Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16D8A34F6AD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 04:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233352AbhCaCcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 22:32:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:57824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233410AbhCaCb5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 22:31:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 15DB7619C5;
        Wed, 31 Mar 2021 02:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617157917;
        bh=4mZ4TlGbfXlzEhrpbM8SPL2JdEzjfPwlKgKzkD43eF4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Zr2sF7IoXuNKSP7rJOgIc808WqRM7LkftWiF7zJOnWqvv8Vv99Gg6U+Bl8tl+DVuC
         EQq3eIgdFCWwxw2MiDZarPSDHLlHvgZYinjLpgoLBSGKwSoDf78+/r320y/ncLlnNl
         blVS9+Wjet2iY0qcFzMNELZP/HJ+WAh/0RB9utHLbI7nBkjOPqwgr7KFs2wCHuDQlW
         4ljGephLEmKrHVgW8bdsIQyQsCivVYQepE4YPUGdzOJa3v5uIwRw9vK5dyx8mktDQI
         o+29YyDoZ4w11fOdZGBziM5eViKjex0Xp+juyoKvWU+loLtgsxBBNlx5NsM+VVTwBV
         Ut7ub3VtTZChg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210302214151.1333447-2-dinguyen@kernel.org>
References: <20210302214151.1333447-1-dinguyen@kernel.org> <20210302214151.1333447-2-dinguyen@kernel.org>
Subject: Re: [PATCH 2/3] clk: socfpga: arria10: convert to use clk_hw
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     dinguyen@kernel.org, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Dinh Nguyen <dinguyen@kernel.org>
Date:   Tue, 30 Mar 2021 19:31:55 -0700
Message-ID: <161715791598.2260335.17297036127669746582@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dinh Nguyen (2021-03-02 13:41:50)
> As recommended by Stephen Boyd, convert the Arria10 clock driver to use
> the clk_hw registration method.
>=20
> Suggested-by: Stephen Boyd <sboyd@kernel.org>
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---

Applied to clk-next

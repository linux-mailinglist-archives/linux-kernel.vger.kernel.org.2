Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9889C39F7B6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 15:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233009AbhFHNYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 09:24:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:57678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232775AbhFHNYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 09:24:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 053F86134F;
        Tue,  8 Jun 2021 13:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623158528;
        bh=gSLXIWErNqPCOIq4EymkmaGyvZ2+ap9lSrJEHlf0/gE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lQoOXl0rFX0sgzUIlOt45yFdSl5UTCUW3UW1V4uTmC6JM5xX2A5T483O7wte28ltC
         HUq9QCghZIgX+1FBc+/oS95bZS1vb7ixmtQuEKspj9sag4jR4L2tRGABYa6Trjf6lq
         9qLWlAOoYaGcmSkxKZJRRc5xEomMfML/5QiyP//mKfaAo0qi3nHcy5nTQsiomoOhjz
         S1g5L+HDn/w3A72uurhMNEUbXaDkZ2ClOPusakB+KoeOCp9Q0WOjXOAGei2hbNZFA3
         ndqYjwYnD5HezeAEwHH3+LoPC9H6S+BEDgOTYseHmj7XArEx2o9LQhfioX7kHd8xu6
         w0R8tA6nDvqxA==
From:   Will Deacon <will@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/hisi: Constify static attribute_group structs
Date:   Tue,  8 Jun 2021 14:21:54 +0100
Message-Id: <162315299460.2245867.18275324199731980593.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210605221514.73449-1-rikard.falkeborn@gmail.com>
References: <20210605221514.73449-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Jun 2021 00:15:14 +0200, Rikard Falkeborn wrote:
> These are only put in an array of pointers to const attribute_group
> structs. Make them const like the other static attribute_group structs
> to allow the compiler to put them in read-only memory.

Applied to will (for-next/perf), thanks!

[1/1] perf/hisi: Constify static attribute_group structs
      https://git.kernel.org/will/c/59d697a99daa

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

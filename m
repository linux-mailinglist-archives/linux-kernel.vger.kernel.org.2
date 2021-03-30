Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41EA134E725
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 14:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbhC3MIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 08:08:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:36094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231749AbhC3MIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 08:08:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 593AF6195B;
        Tue, 30 Mar 2021 12:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617106086;
        bh=7LMZ9F7lPaHwi9le/h++7n7vRCgfrM5V67L1bhRCi+Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jXuYOvZJehXicC4lBBemhDOlN4/mbLo0CTtFE8Gq0yUORmuXpoM53CuJM0UJK9TMF
         EAm4Qg+Ay4P25jM0UIE6J7Cb0B2VYK/P+ykOuJoKlTDhYcMgJqgu5BQT5kLLRQL9xS
         qRTaGb5glQmunn9rVso+aSiU+0SrpvgNS20oI/aZcaGvrM23kRJnSrGhkl+677m9Wk
         Hk/zDiM6oPLWRWGJgW+sn7+MM1Y8x5UIA9oVrDTaQ6umZtStYdgJM4YjM6LbzyCtZ1
         HkjI/GAXoHnjetRIWZjG0I7LWW9Vn8Q/poNBeOsqRluXSgC1jLwhrWhW1Q6DOljGlr
         Upqk/hFHtbQGw==
Date:   Tue, 30 Mar 2021 13:08:02 +0100
From:   Will Deacon <will@kernel.org>
To:     zhouchuangao <zhouchuangao@vivo.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Qais Yousef <qais.yousef@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/kernel/probes: Use BUG_ON instead of if condition
 followed by BUG.
Message-ID: <20210330120801.GA5908@willie-the-truck>
References: <1617105472-6081-1-git-send-email-zhouchuangao@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617105472-6081-1-git-send-email-zhouchuangao@vivo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 04:57:50AM -0700, zhouchuangao wrote:
> It can be optimized at compile time.

Hmm, I don't see it (and I also don't understand why we care). Do you have
numbers showing that this is worthwhile?

Will

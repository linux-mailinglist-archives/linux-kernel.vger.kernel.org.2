Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8F4342D728
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 12:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhJNKcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 06:32:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:34968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230081AbhJNKcG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 06:32:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5CF2D610D0;
        Thu, 14 Oct 2021 10:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634207401;
        bh=L8snuA9IdJYlFePVkyyqVW+0VOmPS5GZ9WVfDXpNAyw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=KcMh3Ct0rGAs/SiKAR9+TsHSFpoQzzAlrC6amnUZELya0AYM26RHYZBBxDIOzW1/1
         MEpneD1gypG9lpHVwg4RcJOQj/3Nes9uR7s0BATpI4lbVR5TeCw8J2Gu1qRKLhdu2K
         qQ9l7Was7jQu8ChnYyp3OX581tWLtApVaakasdhlG/3QQClErYOkAzcaGcgn7Go3JY
         EF4WeMZz5oJ0nDGvndby7AOIWIbF9Nn8CDpD7rmURXGxJuA0b8R+UMeGbCoO48gsFV
         ehzdkwIMkNQK5NWHDNdjBDf6XztKxwEKVXcnClfvlrvYFKFzWppTaw/IvQzT8hdnfH
         ysLh4yQ06Z0wg==
From:   SeongJae Park <sj@kernel.org>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/damon/vaddr: constify static mm_walk_ops
Date:   Thu, 14 Oct 2021 10:29:58 +0000
Message-Id: <20211014102958.28247-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211014075042.17174-2-rikard.falkeborn@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Oct 2021 09:50:41 +0200 Rikard Falkeborn <rikard.falkeborn@gmail.com> wrote:

> The only usage of these structs is to pass their addresses to
> walk_page_range(), which takes a pointer to const mm_walk_ops as
> argument. Make them const to allow the compiler to put them in
> read-only memory.
> 
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]

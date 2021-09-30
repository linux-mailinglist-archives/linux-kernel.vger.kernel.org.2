Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3812341D2B5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 07:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348067AbhI3Fcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 01:32:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:59806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347737AbhI3Fcv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 01:32:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 78B556140F;
        Thu, 30 Sep 2021 05:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632979869;
        bh=RWMIiqbwR5jDjdpGogoNOmRvMNT8dBEuVwxUG8+TDNQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=WAKBRHr/PESK7WdEOx987zFtV58Q1/tSiCjy5y5Whlsl7PROGRqCiDp7qZ+s8IvAF
         bXRpAUtD8FHG44kACKu8wAVWMIV3c3plnzrnDhnkduAscffEpazfTJcVCQvAqp1fYP
         ZwTQiWYc0gn8sZpGlFzDtY52saLVCEFwa+R3BtaRWcRG9sW3ZpWRIQV07oqfAXeO1t
         8pq6NcJ7evDJfjoi6ng/JLfk9T1C3x5rYej5yn3vIoPphHYn4a9egEbvNvDpKjGWHR
         Ij6xpNJxtRA8MkGUDyXv0yXLiHHruFjK5wVfNM5QMjnvDu69HgffJX2E4YeDqlZZyS
         6gYAjHgeqscMg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210924174323.20770-1-songkai01@inspur.com>
References: <20210924174323.20770-1-songkai01@inspur.com>
Subject: Re: [PATCH] time:Fix an incorrect function name in the comment
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Kai Song <songkai01@inspur.com>
To:     Kai Song <songkai01@inspur.com>, john.stultz@linaro.org,
        tglx@linutronix.de
Date:   Wed, 29 Sep 2021 22:31:08 -0700
Message-ID: <163297986834.358640.6810289531257538278@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kai Song (2021-09-24 10:43:23)
> We fix the following warning when building kernel with W=3D1:
> kernel/time/time.c:479: warning: expecting prototype for set_normalized_t=
imespec(). Prototype was for set_normalized_timespec64() instead
>=20
> Signed-off-by: Kai Song <songkai01@inspur.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

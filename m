Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25D9E42D376
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 09:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbhJNHYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 03:24:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:57344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229910AbhJNHYJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 03:24:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B048360E53;
        Thu, 14 Oct 2021 07:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634196125;
        bh=vJAcCpXTn71678QsoXxMqqwnh49Gpqggsk823DPziYg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=Z83luPCKh139KzgzE/6nz8jT79ovw/pI+OXKPM0jKsw21lsJbJv6Eiq/8TvhtoaeT
         LBQWd/56b1Gs7uIjywSBPzfLuNO4yRTrrRdnh4+7Bt2BDoMwjNDC8kk+WtTI/Y2/Io
         LvGqaLQM+SxKEdxJ69ue4o5vMjrDQcL6fY/AME+yPChsLQod/JEFMYi/ETaaQhDseB
         HbKeCYveItaZJTe64cjloeQiLdDQA0SOm0FjnuZiZ0ToURKU1y2pLIPKJHhakpKy1+
         O+sM9SDWGTpYvcDplfE09Z9b3lqN3mVb2OuRMCTBh2Ofe/WNNeb1b+xP+eywW1sZp7
         DLoiozZYKr7sg==
From:   SeongJae Park <sj@kernel.org>
To:     Rongwei Wang <rongwei.wang@linux.alibaba.com>
Cc:     sj@kernel.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2] mm/damon/dbgfs: remove unnecessary variables
Date:   Thu, 14 Oct 2021 07:21:58 +0000
Message-Id: <20211014072158.35478-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211014020333.10330-1-rongwei.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Oct 2021 10:03:33 +0800 Rongwei Wang <rongwei.wang@linux.alibaba.com> wrote:

> In some functions, it's unnecessary to declare 'err'
> and 'ret' variables at the same time. This patch mainly
> to simplify the issue of such declarations by reusing
> one variable.
> 
> Signed-off-by: Rongwei Wang <rongwei.wang@linux.alibaba.com>

Looks good to me.  However, this doesn't cleanly applicable on latest -mm tree.
I will post a rebased version as a reply to this.


Thanks,
SJ

[...]

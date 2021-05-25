Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1210F38FCDD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 10:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbhEYId2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 04:33:28 -0400
Received: from verein.lst.de ([213.95.11.211]:58171 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230041AbhEYId1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 04:33:27 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3623567357; Tue, 25 May 2021 10:31:56 +0200 (CEST)
Date:   Tue, 25 May 2021 10:31:56 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     jlbec@evilplan.org, hch@lst.de, nathan@kernel.org,
        ndesaulniers@google.com, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] configfs: Remove redundant initialization of 'len'
Message-ID: <20210525083156.GB19018@lst.de>
References: <1620811079-105280-1-git-send-email-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1620811079-105280-1-git-send-email-yang.lee@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, but this isn't needed anymore with the patch from Bart that
implements ->read_iter instead of ->read.

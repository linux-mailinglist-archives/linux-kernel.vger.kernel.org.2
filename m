Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEA23BAC6B
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jul 2021 11:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbhGDJVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jul 2021 05:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhGDJVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jul 2021 05:21:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D633BC061762
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jul 2021 02:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ia2Yrz2eLprWC3bTz7vKqcsI8jsgfQIiOUZrEoYqeB4=; b=DrQSe0m32TupCg8vyy8C75tqQB
        lpx9SqMfuNiV/DWS0RLYRuvAlv8g70tNs9kdfFe0z+OJQTltH5vFyMnwFkGSYs95S/1iVaQSO3bwV
        Dh4qwgNmiKxtGVjwnixoKbm3qmJRgorRCfY+c/OKGuvKy0LbF84T6FUwBN/wKBVhfk7SGaDXC/f8R
        3776KP5MXguIaEJgQof68qHKcwnZgn5C9u/+lMlS0p+Y0iUmtwVuj6Mrt2Tnld8Y+VRv0acZf6W51
        y43mRGRgjAVJVduisQKICvFs4n63ZN7NDeiCWs9wr6GMZoZxc7JYI9qZ7eq4DpzgrtQdpnKzxC2Ds
        CTZO9GeQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lzyF5-009CHg-6s; Sun, 04 Jul 2021 09:16:58 +0000
Date:   Sun, 4 Jul 2021 10:16:47 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "wuqiang.matt" <wuqiang.matt@bytedance.com>
Cc:     naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, mhiramat@kernel.org, mingo@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org, mattwu@163.com
Subject: Re: [PATCH] kretprobe scalability improvement
Message-ID: <YOF8fyJIzJmZUhoC@infradead.org>
References: <20210703102818.20766-1-wuqiang.matt@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210703102818.20766-1-wuqiang.matt@bytedance.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Would it make sense to just reuse kernel/bpf/percpu_freelist.c for
kretprobes?

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5A8456104
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 17:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233805AbhKRRBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 12:01:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232689AbhKRRBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 12:01:54 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F2BC061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 08:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VwnOWE2EI3jRaIJyjTGipHIhI0CUUdR9ehfldvBnRGA=; b=CuuD0pqk/4DZ1sH5yjBIyO7Uq6
        oRgkyMMTUksud9Jbuow5hU8gv4eItCoUTD2xegWCCXQ3CpsPqH6eg+v6+Vk8L7OUqXBzVf1JLk/9u
        +NF8lhNnD0W9itNPyl3qEkebv3Lj98z6/YrjRyxeuCJihMg7U7j+u17AbM8qnBbDYCyhVl1tOTXvD
        GsJmOzoMscug2FJzUeaGRIOdhvqiPCRbfzRE3j0fMpCjq+8yoxEduSOw5bsCFvFYqzDu8iNo2H8/y
        6yLy+RXEKug1IEpr3ELhy485kYcxmvlE/4eSZwxEBKJRvjPL/LQpjFimFDaPlcqQgbcIiHyhw2Uly
        QnGn7+Fg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mnkkM-008Pux-KV; Thu, 18 Nov 2021 16:58:50 +0000
Date:   Thu, 18 Nov 2021 08:58:50 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Xiaoming Ni <nixiaoming@huawei.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [mcgrof-next:20211117-sysctl-cleanups-all-set-04 3/36]
 kernel/hung_task.c:69:8: error: 'sysctl_hung_task_timeout_secs' redeclared
 as different kind of symbol
Message-ID: <YZaGSjhIVob3CZYF@bombadil.infradead.org>
References: <202111181912.ihYhUzPE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202111181912.ihYhUzPE-lkp@intel.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2021 at 07:52:20PM +0800, kernel test robot wrote:
> >> kernel/hung_task.c:69:8: error: 'sysctl_hung_task_timeout_secs' redeclared as different kind of symbol
>       69 | enum { sysctl_hung_task_timeout_secs = 0 };

Fixed thanks.

  LUis

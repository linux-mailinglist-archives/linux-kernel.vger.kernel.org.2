Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F020F44F5DF
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 02:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbhKNBUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 20:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbhKNBUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 20:20:21 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A199DC061714
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 17:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=ogYsQKyPjFstbTH+3gt9mKj7Cy4fVZxY5qoPxvgqV5g=; b=EcSkudKggrn26M7wkRPwiS8fmf
        t8QIi4ZiOe/9GR2xoogBYkvH8LLFJDFmcxdQqt2nG2zBYmt/+YKZVflLSmwuVdl8JMe6p/0zOHKyB
        MUpj6HYBkIrm4X501Q04zQTYNaBYz1wjAOlwBbTp7fsFDhj8LRrANi1ZXT3r3zklzTtSxFCFTHtfK
        Il97dq7MAIta8Mtp5V9u6xdW8zy6ch6Yfor9z+LdnAuyPPJ6hnNxqo9FosJaAZb00qIuQD6rkBhwp
        HYvGP89AUCVI1xWz2Cpf2Q1We3cr+4oEsfqLiQ6s12zfIYtTifb+w/GQ7jkMua16JUJZ6l2/EDMpK
        znW+f1Uw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mm48z-00DF6m-CH; Sun, 14 Nov 2021 01:17:17 +0000
To:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: SH: error: implicit declaration of function 'init_cache_node_node'
Message-ID: <b5bdea22-ed2f-3187-6efe-0c72330270a4@infradead.org>
Date:   Sat, 13 Nov 2021 17:17:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

on arch/sh/,
CONFIG_SMP is not defined,
CONFIG_NUMA=y,
CONFIG_MEMORY_HOTPLUG is not defined:

../mm/slab.c: In function 'slab_memory_callback':
../mm/slab.c:1143:23: error: implicit declaration of function 'init_cache_node_node'; did you mean 'drain_cache_node_node'? [-Werror=implicit-function-declaration]
  1143 |                 ret = init_cache_node_node(nid);


commit 76af6a054da4
Author: Dave Hansen <dave.hansen@linux.intel.com>
Date:   Mon Oct 18 15:15:32 2021 -0700

     mm/migrate: add CPU hotplug to demotion #ifdef


How should we handle this config?

-- 
~Randy

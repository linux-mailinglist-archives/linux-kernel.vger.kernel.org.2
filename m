Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5B83F9BDA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 17:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244816AbhH0Pnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 11:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232373AbhH0Pna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 11:43:30 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6298DC061757
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 08:42:41 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id x27so15282338lfu.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 08:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DXkFy+7KOqBdBok+wuJGsKPAoyxzJU89j/0oaIHIjZA=;
        b=nkOxZZeJcN/jVgIAQ0IX6FsblBfB9e3UhUz76awaCgUgNco96rVa6F0car1a3W+s0v
         ieHt6e9iiMTAVlQEiWHPrkztkXarw2BuY156WmazWoxpL6ODtnUpmFHzD1bNObbHApb6
         9BF3+KQuIWevWCfzKv7Hh4CJ/DpMXJjH//Oj/DpF7MoTfAkmYMcTNQE6KEuKYEZhRuyr
         MBfg8O/iYeRGgccQmn1RhVS05h9c/hncMUKUG5Gn0erEKSF0qxFQ/wJeGyQKuXznSEE8
         9mBGXgwhjVHFACuvXjIE30OTyqr8l3KBdXkc8RucKud29eGN961rdND+2DLRPp9fsmYV
         lc9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DXkFy+7KOqBdBok+wuJGsKPAoyxzJU89j/0oaIHIjZA=;
        b=A1ae4oIpO2f16D6P+DzIPypxfem/Eg0t7V67CuUtDbIgubfwmcov4vycjoFoBXHd6z
         FZ5PSQbK1/Jz28VIsAGY0V8zlE2VJdzBxMDt9z8z+fw9xYJurGHEdY3lZy5tce6f3yd9
         ylFbn5xpkROeyQ2WbWp67DBdxb7+z3mPDUJesACuRAgDn179+ADH1w5wgYk+g73jD53H
         2SQmpnxBANy2r2NlQD8uLCfhVFE/kmkLFWxDtEVgJox08cJf3IgMXfYvMMpspAfYtwf8
         adVJYOBXqZLBHqh3KA5kpfoz0WtuzOrtgMYo/oE4JnPxJDmSCjD4IekvugbXyXWoWVIw
         s3fg==
X-Gm-Message-State: AOAM533uPCozqhYOcs0q+A+AGUcerpdCxGiiEM0rnbEBy+j++cXsNSsf
        1FsfeAVf+N58XdYEkLjhgTNLPkvDPRZ3X2ff
X-Google-Smtp-Source: ABdhPJwhJ3kfTrQeKzq5/TV0YCLB0WVHVvx1Tc1mPTlIgkl/LCf8nROPtK+eE87rBUF/40Kmo6o8+w==
X-Received: by 2002:a05:6512:1042:: with SMTP id c2mr7399206lfb.283.1630078955301;
        Fri, 27 Aug 2021 08:42:35 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id e18sm703789ljo.105.2021.08.27.08.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 08:42:34 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id CBD3F102E6A; Fri, 27 Aug 2021 18:42:32 +0300 (+03)
Date:   Fri, 27 Aug 2021 18:42:32 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com
Subject: Re: [mm]  f9ce0be71d:
 BUG:KCSAN:data-race_in_next_uptodate_page/next_uptodate_page
Message-ID: <20210827154232.rrpetqsh5xxklkej@box.shutemov.name>
References: <20210826144157.GA26950@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210826144157.GA26950@xsang-OptiPlex-9020>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2021 at 10:41:57PM +0800, kernel test robot wrote:
> 
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with clang-14):
> 
> commit: f9ce0be71d1fbb038ada15ced83474b0e63f264d ("mm: Cleanup faultaround and finish_fault() codepaths")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> 
> in testcase: trinity
> version: 
> with following parameters:
> 
> 	number: 99999
> 	group: group-04
> 
> test-description: Trinity is a linux system call fuzz tester.
> test-url: http://codemonkey.org.uk/projects/trinity/
> 
> 
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> +------------------------------------------------------------------------+-----------+------------+
> |                                                                        | v5.11-rc4 | f9ce0be71d |
> +------------------------------------------------------------------------+-----------+------------+
> | BUG:KCSAN:data-race_in_next_uptodate_page/next_uptodate_page           | 0         | 19         |
> | BUG:KCSAN:data-race_in_mark_page_accessed/next_uptodate_page           | 0         | 17         |
> | BUG:KCSAN:data-race_in_next_uptodate_page/page_memcg                   | 0         | 13         |
> | BUG:KCSAN:data-race_in_next_uptodate_page/unlock_page                  | 0         | 13         |
> +------------------------------------------------------------------------+-----------+------------+
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
> 
> 
> [  184.717904][ T1873] ==================================================================
> [  184.718938][ T1873] BUG: KCSAN: data-race in next_uptodate_page / unlock_page
> [  184.719828][ T1873]
> [  184.720103][ T1873] write (marked) to 0xffffea00050f37c0 of 8 bytes by task 1872 on cpu 1:
> [  184.721024][ T1873]  unlock_page+0x102/0x1b0
> [  184.721533][ T1873]  filemap_map_pages+0x6c6/0x890
> [  184.722102][ T1873]  handle_mm_fault+0x179c/0x27f0
> [  184.722672][ T1873]  do_user_addr_fault+0x3fb/0x830
> [  184.723263][ T1873]  exc_page_fault+0xc3/0x1a0
> [  184.723845][ T1873]  asm_exc_page_fault+0x1e/0x30
> [  184.724427][ T1873]
> [  184.724720][ T1873] read to 0xffffea00050f37c0 of 8 bytes by task 1873 on cpu 0:
> [  184.725575][ T1873]  next_uptodate_page+0x456/0x830
> [  184.726161][ T1873]  filemap_map_pages+0x728/0x890
> [  184.726747][ T1873]  handle_mm_fault+0x179c/0x27f0
> [  184.727332][ T1873]  do_user_addr_fault+0x3fb/0x830
> [  184.727905][ T1873]  exc_page_fault+0xc3/0x1a0
> [  184.728440][ T1873]  asm_exc_page_fault+0x1e/0x30
> [  184.729027][ T1873]
> [  184.729313][ T1873] Reported by Kernel Concurrency Sanitizer on:
> [  184.730019][ T1873] CPU: 0 PID: 1873 Comm: systemd-udevd Not tainted 5.11.0-rc4-00001-gf9ce0be71d1f #1
> [  184.731103][ T1873] ==================================================================

Line annotation would be helpful.

And I'm not very familiar with KCSAN. My guess it reports PageLock() vs.
clearing PG_locked. In this context it looks safe, unless I miss
something.

Do we need some annotation to help KCSAN?

-- 
 Kirill A. Shutemov

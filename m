Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE1945CA50
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 17:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349154AbhKXQtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 11:49:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47840 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241782AbhKXQtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 11:49:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637772349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f+K/KjRISkHJ/MQg0AcZ5rDgTt6cOMR3R7fi9euQAsE=;
        b=bk4t48bpXNbEIRfAst1NmWUw1vV4R1dX+BUmKH9FMC7L9aNGE51mfcZCEdnOHIHXChvQeh
        ss2Hy1dfcPxh0+bnc8Iw68V4/3VfKB/vqOP7IdwZ3CC1jpeFcvW5Jrk6+jERuBvvQOF9ZH
        eeg4zngYn5P3vFEM4NHc2RUG4Ktjxyg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-106-SlQhqTQvMraxUGrA40QsJA-1; Wed, 24 Nov 2021 11:45:48 -0500
X-MC-Unique: SlQhqTQvMraxUGrA40QsJA-1
Received: by mail-wm1-f69.google.com with SMTP id 205-20020a1c00d6000000b003335d1384f1so3303492wma.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 08:45:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=f+K/KjRISkHJ/MQg0AcZ5rDgTt6cOMR3R7fi9euQAsE=;
        b=YlJ1nYEFpB2285Co7rWXOQ6IEbOT0VeWRq6bVp+qGZePHkgWoVDhOuiFARa/A3Vi/Q
         tZ7QYw0qN2BarWcQSUX6cTKVVYcUJA3UaN85eP/WkUpTsq7zQokho7eBCqev5ewFkeAC
         9kowj9OMT9KUgnI9mx95LDEsv4AukB9fw9YjulADBkF0YqfWeC4JLC7cMihQYmDUg4sK
         criAtBWvtJS+g/SLkS8bIS3n4NihyQRU0IQgdxbNALTk8AeVDflByRapTSRhHGiod3qT
         5ynA+0kO1uc+k+Nuc6fHF6D3AFRJQFMovgxa5/ACh2dRmasmaIyzQ8teqEFcR5QcBmbC
         TagA==
X-Gm-Message-State: AOAM533wtapakDSceXjjGYwD8c2JRqtrG0M/7joCNrXV+6gyqkO3dSmD
        LzYUX74sHGYaRPOW3af4Tn8eNT7xdax796wfjsal2SA78n1y2HU24NJiV7jI3LU7r5QBCOL24xA
        DBjak83bzOsyntScoMW3KJYDa
X-Received: by 2002:a1c:23cb:: with SMTP id j194mr17320168wmj.13.1637772347105;
        Wed, 24 Nov 2021 08:45:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwaIbs9H/CUbL57MmVNbDGiXWtNy0iS+C0D9EsV+y0cgyAMq3U+0C0DXnHG+qHj3Xgj+rkSBA==
X-Received: by 2002:a1c:23cb:: with SMTP id j194mr17320125wmj.13.1637772346843;
        Wed, 24 Nov 2021 08:45:46 -0800 (PST)
Received: from [192.168.3.132] (p5b0c6380.dip0.t-ipconnect.de. [91.12.99.128])
        by smtp.gmail.com with ESMTPSA id h27sm5900948wmc.43.2021.11.24.08.45.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Nov 2021 08:45:46 -0800 (PST)
Message-ID: <5166da50-e2af-139b-9f7f-a1bcabe10775@redhat.com>
Date:   Wed, 24 Nov 2021 17:45:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: fs/proc/vmcore.c:161:34: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
References: <202111242331.x19Qywph-lkp@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <202111242331.x19Qywph-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.11.21 16:42, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   5d9f4cf36721aba199975a9be7863a3ff5cd4b59
> commit: c1e63117711977cc4295b2ce73de29dd17066c82 proc/vmcore: fix clearing user buffer by properly using clear_user()
> date:   4 days ago
> config: ia64-allyesconfig (https://download.01.org/0day-ci/archive/20211124/202111242331.x19Qywph-lkp@intel.com/config)
> compiler: ia64-linux-gcc (GCC) 11.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # apt-get install sparse
>         # sparse version: v0.6.4-dirty
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c1e63117711977cc4295b2ce73de29dd17066c82
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout c1e63117711977cc4295b2ce73de29dd17066c82
>         # save the config file to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=ia64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> 
> sparse warnings: (new ones prefixed by >>)
>>> fs/proc/vmcore.c:161:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __user *p @@     got char *buf @@
>    fs/proc/vmcore.c:161:34: sparse:     expected void const [noderef] __user *p
>    fs/proc/vmcore.c:161:34: sparse:     got char *buf
>>> fs/proc/vmcore.c:161:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user * @@     got char *buf @@
>    fs/proc/vmcore.c:161:34: sparse:     expected void [noderef] __user *
>    fs/proc/vmcore.c:161:34: sparse:     got char *buf
> 
> vim +161 fs/proc/vmcore.c
> 
>    133	
>    134	/* Reads a page from the oldmem device from given offset. */
>    135	ssize_t read_from_oldmem(char *buf, size_t count,
>    136				 u64 *ppos, int userbuf,
>    137				 bool encrypted)
>    138	{
>    139		unsigned long pfn, offset;
>    140		size_t nr_bytes;
>    141		ssize_t read = 0, tmp;
>    142	
>    143		if (!count)
>    144			return 0;
>    145	
>    146		offset = (unsigned long)(*ppos % PAGE_SIZE);
>    147		pfn = (unsigned long)(*ppos / PAGE_SIZE);
>    148	
>    149		down_read(&vmcore_cb_rwsem);
>    150		do {
>    151			if (count > (PAGE_SIZE - offset))
>    152				nr_bytes = PAGE_SIZE - offset;
>    153			else
>    154				nr_bytes = count;
>    155	
>    156			/* If pfn is not ram, return zeros for sparse dump files */
>    157			if (!pfn_is_ram(pfn)) {
>    158				tmp = 0;
>    159				if (!userbuf)
>    160					memset(buf, 0, nr_bytes);
>  > 161				else if (clear_user(buf, nr_bytes))
>    162					tmp = -EFAULT;
>    163			} else {
>    164				if (encrypted)
>    165					tmp = copy_oldmem_page_encrypted(pfn, buf,
>    166									 nr_bytes,
>    167									 offset,
>    168									 userbuf);
>    169				else
>    170					tmp = copy_oldmem_page(pfn, buf, nr_bytes,
>    171							       offset, userbuf);
>    172			}
>    173			if (tmp < 0) {
>    174				up_read(&vmcore_cb_rwsem);
>    175				return tmp;
>    176			}
>    177	
>    178			*ppos += nr_bytes;
>    179			count -= nr_bytes;
>    180			buf += nr_bytes;
>    181			read += nr_bytes;
>    182			++pfn;
>    183			offset = 0;
>    184		} while (count);
>    185	
>    186		up_read(&vmcore_cb_rwsem);
>    187		return read;
>    188	}
>    189	

Sparse is wrong as it doesn't see the bigger picture. "int userbuf"
tells us what we're actually dealing with ...


-- 
Thanks,

David / dhildenb


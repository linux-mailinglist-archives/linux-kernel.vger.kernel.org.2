Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4343CCAE4
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jul 2021 23:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbhGRVbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 17:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233231AbhGRVbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 17:31:12 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01432C061764
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jul 2021 14:28:13 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id l11so7760775ljq.4
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jul 2021 14:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RDmZbfk4umt1NTgReOWa0nlo9wbj8HPSJ0b72AWtHlI=;
        b=m3X+8h5sNcmib/Jzd1hwMXGfSUSimXJ8rCCYFjWXgqdSTHMLURCciTa1Gkf8rtY8gF
         IncY0rxbJp7diuFaM+sFO05fUn4c92aIEMDVyrXI8pBY4anM35msGOlHF0MDM4G62Dk2
         FhjzD5Th/XMP9NIJnqKS/cWnewOk8N41dGlkiPqK/TQK+uGp9PoN7en3TFzuESVIRDVe
         kr2/rVucVrHylll2n8fEOui5IgqOAIj4yZKDt0w5Td30AqPv6TC7MY5vZrLeh82nYqP9
         3pq3j/JTjz9QWloFIbVWejNWh2rAHLrHh4gy2ZCayJtoD1AYG6AVo/w29miAlO0N3kz/
         cokg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RDmZbfk4umt1NTgReOWa0nlo9wbj8HPSJ0b72AWtHlI=;
        b=oC+MdJKK/QNq7mnCF4urJ2spf1yYkDmJaKeWWhoWrKpMuHBuvHCDIf3FdQZ2vL1dj3
         Fp4nlNDxhg6FazjnjN+k6zhf9I/wOdqlCbJNsiu/GrOagwXihyAo4LlPbJ5aztXAK3dj
         aIKRnxiGxRsncKAQ0hj1Ye9oIcbzBQIBJU4icy5puVzns1ydqPMVBqtUblQ+QZdNH/xk
         ssUsmU+5dvih4oFIYydaUZiMj7A5tqv82yZ/VMcByBq6w+pIWNDrRua0UCLaTly+cZK3
         ZjEX4UL+ouwAvmtytRdjFGjzLcWHGA5zBk+v8xu8XgjWvhp1AzH2c5EPf/k0RrKGoYsr
         b6xQ==
X-Gm-Message-State: AOAM5326ikrXkgiAxWlEKTKrg001Femj+GEEFEHleL5vNqFkzZSMZq8B
        qJeyAPrebzSiTx6ChfBOUccBVw==
X-Google-Smtp-Source: ABdhPJzslQtZZUuJs3gEJ2cjkwE33akLtrf7biZvMZ6KhTw7w+qis1t8Cmc/qZBJE6B/zyxqPlhZpA==
X-Received: by 2002:a2e:3506:: with SMTP id z6mr20511573ljz.238.1626643691394;
        Sun, 18 Jul 2021 14:28:11 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id z13sm1232704lfb.40.2021.07.18.14.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jul 2021 14:28:10 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 6C5B610260F; Mon, 19 Jul 2021 00:28:14 +0300 (+03)
Date:   Mon, 19 Jul 2021 00:28:14 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     akpm@linux-foundation.org, tglx@linutronix.de, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com
Subject: Re: [PATCH 1/7] mm: fix the deadlock in finish_fault()
Message-ID: <20210718212814.suvziikndiyezi6m@box.shutemov.name>
References: <20210718043034.76431-1-zhengqi.arch@bytedance.com>
 <20210718043034.76431-2-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210718043034.76431-2-zhengqi.arch@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 18, 2021 at 12:30:27PM +0800, Qi Zheng wrote:
> The commit 63f3655f9501(mm, memcg: fix reclaim deadlock with writeback)
> fix a deadlock bug by pre-allocating the pte page table outside of the
> page lock, the commit f9ce0be71d1f(mm: Cleanup faultaround and
> finish_fault() codepaths) rework the relevant code but ignore this race,
> fix it.
> 
> Fixes: f9ce0be71d1f(mm: Cleanup faultaround and finish_fault() codepaths)
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

and add stable@, please.

-- 
 Kirill A. Shutemov

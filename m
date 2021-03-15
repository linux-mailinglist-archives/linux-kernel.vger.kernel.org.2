Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D430733AB5D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 07:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhCOGA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 02:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbhCOGAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 02:00:04 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBE5C061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 23:00:03 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id t9so5053225wrn.11
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 23:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KOvvV7RR2japda/QLFsyXLfM22nNp7ARHTQim4IJaMg=;
        b=f63X4hR6IyFmvatcjhANcDApy6+9Sg0QLM0WugR7Md/KTp5ik/re16f8DohbXR7fQ0
         sejhZfVn77t/qCOE7nMVT/WXoGbzM4J3oQKgaxTrA3Scvod7nNv5fttHeRBBgWDkZBPs
         py+0KQiHoUrMGCLe0VUMPcYUEql1H4pZnZuqtVmYRbsiCk8ahEpwkSNI211NgCgiwD7A
         +9Nimgcu51YwgNdnysTP54ZUVdGLa3hlpy9gu57ZgaihrZ/e+clZGJCG4iZMpu8YkB6p
         Lt7nZIN/NsNqKAVyMomk8RSThH3hQ1DWprscPolZMd5fSJyPyseTaM728wTMQpY8h+X8
         6IUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KOvvV7RR2japda/QLFsyXLfM22nNp7ARHTQim4IJaMg=;
        b=kSwsbTVmndf3wgHNwi2X4MhrLHGJxfdJWHmBqSJMbawqx1MiWBINY+dCS/JBJS9Bcm
         u6CBNRvWQ7vgzRR/80qiudNC5zoCB3VOfcgfp9AtQoWweS5ZRmD2XCpTvSR2iIjMtWgc
         vsXePu9ZpGySXk+ap0HGartM2smeZ0RIq41AFc5Ez2Rdb2JqP0pZM28t1X9Cm+xkqxGC
         FFkrQW5lEf3ws0fAO/bOeeDfvQOGjGD7zMvt4+oMRoS3ewYe3yJJoRHJmVVosgGNM+2v
         eDSkFUZpeoP/hHvfvlbUQDPK/qBdWCp1t24yy6eArD92/NpeP5Xl2c0N0jV0E6Pjm9sJ
         rqqQ==
X-Gm-Message-State: AOAM531xftvDgGvfcUH883UU+/IM0/CJi1oB5DLBph3jSsO8Q58mwbCY
        oU2mYfBSYi4iShFRWCvgsnhjEo+Afg==
X-Google-Smtp-Source: ABdhPJwzWsTuHvHBs/tyMID4TOW9jX/oqUT03wp6/FjnCyQ279D45QqLyZhPOuvGIjPcAdeXpMaAyA==
X-Received: by 2002:a5d:4e0b:: with SMTP id p11mr26148924wrt.343.1615788002017;
        Sun, 14 Mar 2021 23:00:02 -0700 (PDT)
Received: from localhost.localdomain ([46.53.252.141])
        by smtp.gmail.com with ESMTPSA id u20sm18714285wru.6.2021.03.14.23.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 23:00:01 -0700 (PDT)
Date:   Mon, 15 Mar 2021 09:00:00 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Linus Torvalds <torvalds@linuxfoundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        gorcunov@openvz.org
Subject: auxv stuff (Re: [PATCH] prctl: fix PR_SET_MM_AUXV kernel stack leak)
Message-ID: <YE734MgE40jTv9zJ@localhost.localdomain>
References: <YE53QiJuxsCUeoiu@localhost.localdomain>
 <CAHk-=wgMm=PG3uxfpmYpkX-GaDAR09pej=t3nD6hHDNCYCyaRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgMm=PG3uxfpmYpkX-GaDAR09pej=t3nD6hHDNCYCyaRQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 14, 2021 at 02:40:05PM -0700, Linus Torvalds wrote:
> [mm->saved_auxv]
> 
> That's a separate issue, and I can't find it in myself to care (and
> nobody has ever complained), but I thought I'd mention it.

There is another (non-security) one. Compat 32-bit process will report
2 longs too many:

00000000  20 00 00 00 40 85 f5 f7  21 00 00 00 00 80 f5 f7  | ...@...!.......|
00000010  10 00 00 00 ff fb 8b 0f  06 00 00 00 00 10 00 00  |................|
00000020  11 00 00 00 64 00 00 00  03 00 00 00 34 80 04 08  |....d.......4...|
00000030  04 00 00 00 20 00 00 00  05 00 00 00 08 00 00 00  |.... ...........|
00000040  07 00 00 00 00 90 f5 f7  08 00 00 00 00 00 00 00  |................|
00000050  09 00 00 00 25 83 04 08  0b 00 00 00 00 00 00 00  |....%...........|
00000060  0c 00 00 00 00 00 00 00  0d 00 00 00 00 00 00 00  |................|
00000070  0e 00 00 00 00 00 00 00  17 00 00 00 00 00 00 00  |................|
00000080  19 00 00 00 8b 27 99 ff  1a 00 00 00 02 00 00 00  |.....'..........|
00000090  1f 00 00 00 f0 2f 99 ff  0f 00 00 00 9b 27 99 ff  |...../.......'..|
000000a0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
	  AT_NULL     AT_NULL	   ^^^^^^^^^^^^^^^^^^^^^^^
000000b0

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0383D01CE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 20:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbhGTR7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 13:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbhGTR7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 13:59:12 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B525CC061574;
        Tue, 20 Jul 2021 11:39:41 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id f9so27047133wrq.11;
        Tue, 20 Jul 2021 11:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:reply-to:date:message-id:mime-version;
        bh=eOQenksWbzUho8FoL7hfu0g/kZQhtfgj2z9YcafSASU=;
        b=di9Z84CFSZnu2xoZlTn2tW17IdiGyWKE11+lYP0gftt527xx3x9MM88TJGGRKsrB2j
         DQSfx4a+fAGqH9ItdoXiyDQVm52zvuN3OCc+qurH4LAE5tjJCG3mPx01DTYAQeaL/dxg
         qDYRWLi9IqR3CtkaJS1PvcGtgejL0HsKmfcHIszo9cSFkKyvDHW76xiEq0bYSHycbO45
         eQFblaL9w2YbNXJAZ/ThlxIEGrOZSUD/ZXuAtuBIOhBW1kvVaISjyTfVezPdEnFAPktT
         5xAS1FqLVURgXPT9BvL+bTinGFQ9oarMYkXm0qj+avhPEbxZ5iUoUJh6M09RDKsdNRvh
         NfWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:reply-to:date:message-id
         :mime-version;
        bh=eOQenksWbzUho8FoL7hfu0g/kZQhtfgj2z9YcafSASU=;
        b=Mn5BcWGeL12tU+04P8Tje4cwWf7GBEpxNdjlFX3coqfl3VSPS7M2vjlzqxb+KVPoBV
         rG46pOn0eWTMZSTeD8Jzfri7Ku+iTJEkK6Ca/NERF20H4pTEKYvje9cVp7Q/bxfG17ne
         R6205VIjvJt13eHoo79icPxor2F/buSF2vo/yf22dR58S84PNIFZBEH8bTEVOHh7d5+5
         kEA7bulhAMuAtUAYpbUQWypfx9nokpBUBk4ccfjnf9lPVQJ3A/upB/IWDwN7//jmxsms
         2hQLJnT+lMyySjtBkj+zRtCHlNy/M0YadOeAmq+YGp/LtcY1KAaQAbJ2jg4TdIQL+dZs
         D2sA==
X-Gm-Message-State: AOAM530WAAxJ+yAr2F7Kudk8JbBKSRjNh/hq6RhhcKhuCLW/ie6fucTo
        9xBHwxydYRVnGzGZNSkOR0UlsQTPUg4=
X-Google-Smtp-Source: ABdhPJyEFky+gostcElITgVjASqAglgBa3ZiO6cyeNuADbNMm2dKXbt5rQBQQyx/j6W5Wwa3Dot4hA==
X-Received: by 2002:adf:f74f:: with SMTP id z15mr37903077wrp.54.1626806380316;
        Tue, 20 Jul 2021 11:39:40 -0700 (PDT)
Received: from jvdspc.jvds.net ([212.129.81.137])
        by smtp.gmail.com with ESMTPSA id j23sm2951504wmo.26.2021.07.20.11.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 11:39:39 -0700 (PDT)
Received: from jvdspc.jvds.net (localhost [127.0.0.1])
        by jvdspc.jvds.net (8.16.1/8.15.2) with ESMTPS id 16KIdcow358870
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 20 Jul 2021 19:39:38 +0100
Received: (from jvd@localhost)
        by jvdspc.jvds.net (8.16.1/8.16.1/Submit) id 16KIdbw2358869;
        Tue, 20 Jul 2021 19:39:37 +0100
X-Authentication-Warning: jvdspc.jvds.net: jvd set sender to jason.vas.dias@gmail.com using -f
From:   "Jason Vas Dias" <jason.vas.dias@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-8086@vger.kernel.org,
        ndetdev@vger.kernel.org
Subject: re: /proc/net/{udp,tcp}{,6} : ip address format : RFC : need for
 /proc/net/{udp,tcp}{,6}{{n,h},{le,be}} ?
Reply-To: "Jason Vas Dias" <jason.vas.dias@gmail.com>
Date:   Tue, 20 Jul 2021 19:39:37 +0100
Message-ID: <hhr1fsvnh2.fsf@jvdspc.jvds.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


RE:
On 20/07/2021, Randy Dunlap <rdunlap@infradead.org> wrote:
> On 7/20/21 2:14 AM, Jason Vas Dias wrote:
> ... 
> Hi,
> I suggest sending your email to  ndetdev@vger.kernel.org
> g'day.

Good day -

 I noticed that /proc/net/{udp,tcp} files (bash expansion) - the IPv4
 socket tables - contain IPv4 addresses in hex format like:

   0100007F:0035

  (Little-Endian IPv4 address 127.0.0.1 , Big Endian port 53)

 I would have printed / expected the IPv4 address to be printed EITHER
 like:
   7F000001:0035  (Both Big-Endian)
 OR
   0100007F:3500  (Both Little-Endian)
 .

 It is rather idiosyncratic that Linux chooses
 to print Little-Endian IPv4 addresses, but not
 Little-Endian Ports , and where the other numbers
 eg. (rx:tx) , (tr:tm/when) in those files are all
 Big-Endian.  

 Perhaps a later version of Linux could either
 A) Print ALL IP addresses and Ports and numbers in network
    (Big Endian) byte order, or as IP dotted-quad+port strings
    ; OR:
 B) Provide /proc/net/{udp,tcp}{,6}{n,be,h,le,ip} files
    ( use shell : $ echo 
    which print IPv4 addresses & Ports in formats:
     n: network: always Big Endian
     h: host: native either Little-Endian (LE) or Big Endian (BE)
     be: BE - alias for 'n'
     le: LE - alias for 'h' on LE platforms, else LE
     ip: as dotted-decimal-quad+':'decimal-port strings, with numbers in BE.
     ; OR:
 C) Provide /proc/net/{udp,tcp}{,6}bin memory mappable binary socket
    table files
    .
 ?

 Should I raise a bug on this ?

 Rather than currently letting users discover this fact
 by mis-converting IP addresses / ports initially as I did at first.

 Just a thought / request for comments.

 One would definitely want to inform the netstat + lsof + glibc
 developers before choosing option A .

 Option B allows users to choose which endianess to use (for ALL numbers)
 by only adding new files, not changing existing ones.

 Option C would obviate the need to choose an endianess file by
 just providing one new memory-mappable binary representation
 of the sockets table, of size an even multiple of the page-size,
 but whose reported size would be (sizeof(some_linux_ip_socket_table_struct_t) *
 n_sockets_in_table). It could be provided alongside option B.

 I think options B and / or C would be nice to have - I might implement an
 extension to the procfs code that prints these socket tables to
 do this, maybe enabled by a new experimental 
 '+rational-ip-socket-tables' boot option -
 then at least it would be clear how the numbers in those files are
 meant to be read / converted.

All the best,
Jason






  

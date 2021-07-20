Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE9493CF6B7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 11:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235276AbhGTIgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 04:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234988AbhGTIeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 04:34:17 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361CFC061574;
        Tue, 20 Jul 2021 02:14:17 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id f8-20020a1c1f080000b029022d4c6cfc37so1045912wmf.5;
        Tue, 20 Jul 2021 02:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:reply-to:date:message-id:mime-version;
        bh=+GcYhvCkG0nF6Zw2BBvM+1MyP49pbxXL8NMXyfEzDF8=;
        b=qUWG1SFlvLeh8MPoN8Vp58/XI+cMJKauP4oMdnYhtD0L2S9O92Lpb0Z8H/C8bYlTyT
         T7ABO/rMuurHowXDUValpwG6/rbKD1ld/9Z3T7rOoTMIyhOOhJysC6kZZGfhRGTVWj/h
         D59UOdTJz1CcL88C4AtZCC5iOjzxDVX9CclNGGHw/KafZRNiI8UQlIz0VkC+wj8dUOIS
         o6dJRUKTsOX2Dkyh6hmKdp6yjIuIa8x4lflK6/zCkj+kK6RF42EK06S75eQFJ4OzED2m
         9L0euQKmqLo6mKN8MZX6CmuU53g7HhonGKj1Il7m6eYHh64HzvJwLuCtwZmlazLc3e8U
         v48Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:reply-to:date:message-id
         :mime-version;
        bh=+GcYhvCkG0nF6Zw2BBvM+1MyP49pbxXL8NMXyfEzDF8=;
        b=bG7dnX+hRIclST8uRuUd7bCPD9esgWEdAfX2EdEWW3pDRSOVvlz4gzvMrBMqAIFLvY
         V7I3HiLVBOJSYpCcvNDGwTlb1zNbBiTbdZRmusr3obDitWVQ34UpovcPtSCOWg6aiebT
         CZOdV5OQ/8XD64b5bZIXycjLT/ZNTucgTeRsTUf8huk5C0mMX0kCkC/U9nj0Oy2AQwGB
         sAzTf6OQQGh4i8ew2kzfhMGlFNtwP2WLK0+wh7CIvcyM4/nOpbXMG3tAi6Qmj8+3KJ2Z
         0qFio/x8u+rPIUDDEqZbwnAs0QUoc1Ccm9ohT5b1NZXSK6eLSccKvJvPNt9xPRMh01Bt
         8dhA==
X-Gm-Message-State: AOAM533pT6MPveOREoA02EBnQCx/czx1f+Uo4vt08lc6tzRzTSD2fvF/
        ZDThLSdIzJrRshPHeRqQeWBUMVkT/OI=
X-Google-Smtp-Source: ABdhPJxkNjR7bIQSgIgjeAX5aQV1qMDyacxBmCLIEkcZ5KjOYL1MSpbD7puPRGLCl3kfUfuY5TTeHw==
X-Received: by 2002:a05:600c:430c:: with SMTP id p12mr37231933wme.16.1626772455773;
        Tue, 20 Jul 2021 02:14:15 -0700 (PDT)
Received: from jvdspc.jvds.net ([212.129.81.137])
        by smtp.gmail.com with ESMTPSA id n23sm19362537wmc.38.2021.07.20.02.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 02:14:14 -0700 (PDT)
Received: from jvdspc.jvds.net (localhost [127.0.0.1])
        by jvdspc.jvds.net (8.16.1/8.15.2) with ESMTPS id 16K9EESl295025
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 20 Jul 2021 10:14:14 +0100
Received: (from jvd@localhost)
        by jvdspc.jvds.net (8.16.1/8.16.1/Submit) id 16K9ED1N295023;
        Tue, 20 Jul 2021 10:14:13 +0100
X-Authentication-Warning: jvdspc.jvds.net: jvd set sender to jason.vas.dias@gmail.com using -f
From:   "Jason Vas Dias" <jason.vas.dias@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-8086@vger.kernel.org
Subject: /proc/net/{udp,tcp}{,6} : ip address format : RFC : need for
 /proc/net/{udp,tcp}{,6}{{n,h},{le,be}} ?
Reply-To: "Jason Vas Dias" <jason.vas.dias@gmail.com>
Date:   Tue, 20 Jul 2021 10:14:13 +0100
Message-ID: <hhy2a1uz2y.fsf@jvdspc.jvds.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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






  

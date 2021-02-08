Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84FD6312A9D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 07:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbhBHGSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 01:18:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbhBHGSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 01:18:00 -0500
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DD9C06174A
        for <linux-kernel@vger.kernel.org>; Sun,  7 Feb 2021 22:17:19 -0800 (PST)
Received: by mail-vs1-xe2c.google.com with SMTP id d24so543047vso.6
        for <linux-kernel@vger.kernel.org>; Sun, 07 Feb 2021 22:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=eecUXzeI5FjGKEff/R+QLVXUOZg+Twh93A2MQZfDyq8=;
        b=gNSFrv68RMEssy0EdjZhLwemnosDwLA9VqmRgBUc91Iic+pXsIm0Hs8BUWGAV8JXPl
         qEAhVe+dLi7ko5okaL8PL3eKZU0k0gGk4ZxDlfnRuEHopR2xu7+h7yyHqCNcfTo6mImg
         hgXDxAe3t855PZSS5HAAgv2s4p042JBb6Gaj9pWKAdRf/J+1K5BpuHq3YO4ulqG56XtW
         4srMqcQrYgpWii5Q/cAOvCbtsmSOR4xmEcUs7iIUdYX1a7WZmS1qfB9aqmS5JGGbJcOH
         vz0K2auD0uTsajwbDV+vMMqT4cYUrm67DZP+sa7brvoKyIyBCH8qRSuCLTEgxNqZ+GNb
         HyVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=eecUXzeI5FjGKEff/R+QLVXUOZg+Twh93A2MQZfDyq8=;
        b=FqeVVJwEy487y3Xsiy7Xt9lyukAs7MXhpaATZoUDIGcCsHVTQraQgefBCtQ3ukVXOV
         6arv6SePO1ib/tIXOqiW88unUIL9V4y3DiI0s6hrJArR4kRuIm5l9iRH9Rjkl+0XyaeO
         QScrLLVglw/veQf1G4Rv8UFCwfXQ8bilr655Il8iO/qmnAxB8AtpnUjlzG+xn9iKX9Zq
         Ny6jkNAtL1SiJ9w1i22U2W6jC+Ty04/dG/pBcuR4+xLlu7vDTOu4NJ7lXQlChkFt3X0v
         5VbExSAQIy3fSqRZnQUV1gupbxR7ww+sZr76Avti1NlcFTjz2BgTw3B0CsDkQleHn7sK
         PAvg==
X-Gm-Message-State: AOAM531fz5vwISNLQFzTDKPTIIGvZw5Gz46M5rfDVDuN4f5L46OW09jF
        jFfQoZBHSkHXdeORL85qwci1FKQIMfKn50bRnEHHnL1Exm6NYA==
X-Google-Smtp-Source: ABdhPJwxXybeUzyMTe2TIIiXfwlWQIfcV4OCm8pOdFC/2c1Te4TJKKcUspkmL09HyE+sneYXbhBQjlLNWhsm37NYOw8=
X-Received: by 2002:a67:eeca:: with SMTP id o10mr9125568vsp.30.1612765038366;
 Sun, 07 Feb 2021 22:17:18 -0800 (PST)
MIME-Version: 1.0
From:   Shu Ming <sming56@gmail.com>
Date:   Mon, 8 Feb 2021 14:17:07 +0800
Message-ID: <CANt8P=vAXdTSweDEODakA3N6pqH6MLQpjHDeBzXh+uUSQofXTg@mail.gmail.com>
Subject: Incorrect RSS page accounting of processes with multiple mapping pages
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I believe there is an unexpected  RES page accounting when doing
multiple page mapping.  The sample code was pasted below.   In the
sample code,  The same 1g pages are mapped for three times.  And it is
expected that the process gets 1g RES instead of 3g RES pages(top
command showed result).

memfd.c
----
#include <stdio.h>
#include <stddef.h>
#include <unistd.h>
#include <sys/mman.h>
#include <sys/syscall.h>
#include <linux/memfd.h>
#include "memfd.h"

const size_t SIZE = 1024*1024*1024; // 1g

int main() {
    long step=0;
    long UNITS = SIZE / 4;
    int fd = memfd_create("testmemfd", MFD_ALLOW_SEALING);
    // replacing the MFD_ALLOW_SEALING flag with 0 doesn't seem to
change anything
    if (fd == -1) {
        perror("memfd_create");
    }
    if (ftruncate(fd, SIZE) == -1) {
        perror("ftruncate");
    }
    void * data1 = mmap(NULL, SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
    if (data1 == MAP_FAILED) {
        perror("mmap");
    }
    void * data2 = mmap(NULL, SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
    if (data2 == MAP_FAILED) {
        perror("mmap");
    }
    void * data3 = mmap(NULL, SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
    if (data3 == MAP_FAILED) {
        perror("mmap");
    }
    //close(fd);
    // removing close(fd) or the mmap() code doesn't seem to change anything

    printf("%d\n", fd);
    while (1) {
       step = step % UNITS;
       ((int *)data1)[step] = 1;
       ((int *)data2)[step] = 2;
       ((int *)data3)[step] = 3;
       step++;
    }
    return 0;
}

----
memfd.h

#ifndef _MEMFD_H
#define _MEMFD_H

/*
 *  * SPDX-License-Identifier: Unlicense
 *   *
 *    * No glibc wrappers exist for memfd_create(2), so provide our own.
 *     *
 *      * Also define memfd fcntl sealing macros. While they are already
 *       * defined in the kernel header file <linux/fcntl.h>, that file as
 *        * a whole conflicts with the original glibc header <fnctl.h>.
 *         */

static inline int memfd_create(const char *name, unsigned int flags) {
    return syscall(__NR_memfd_create, name, flags);
}

#ifndef F_LINUX_SPECIFIC_BASE
#define F_LINUX_SPECIFIC_BASE 1024
#endif

#ifndef F_ADD_SEALS
#define F_ADD_SEALS (F_LINUX_SPECIFIC_BASE + 9)
#define F_GET_SEALS (F_LINUX_SPECIFIC_BASE + 10)

#define F_SEAL_SEAL     0x0001  /* prevent further seals from being set */
#define F_SEAL_SHRINK   0x0002  /* prevent file from shrinking */
#define F_SEAL_GROW     0x0004  /* prevent file from growing */
#define F_SEAL_WRITE    0x0008  /* prevent writes */
#endif

#endif /* _MEMFD_H */

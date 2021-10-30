Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAD62440856
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 12:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbhJ3KFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Oct 2021 06:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbhJ3KFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Oct 2021 06:05:53 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E46C061570
        for <linux-kernel@vger.kernel.org>; Sat, 30 Oct 2021 03:03:23 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id n11so2360037iod.9
        for <linux-kernel@vger.kernel.org>; Sat, 30 Oct 2021 03:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=paojrnHhCk6joQkSbRPWuj8brKBNVDh4fOd9v9QT3yk=;
        b=r2keU11IaANOfySqmFsKeGHwR0AIOY4OIGLRQ5FFczqYA2aku5Jjs50BR9riOvlojW
         fvsZI0XApQ+mSc9xKn9KH/ya7nMwTYCPldyYq37qd7Rs27v6lOMNGOayyw0nxWTiEgKb
         icMBuHZNg4anOtmhLOsZ6Fn65N6BXBRBzR1bg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=paojrnHhCk6joQkSbRPWuj8brKBNVDh4fOd9v9QT3yk=;
        b=3ZmZGguGlMr3X76XkENP4y+Kf4XIXvtWI5/jzwSatevJonD8zrHcnElAU6i95bRw7q
         1dl15uWZ5mT6jZkASMUfFSHKIpR+R530qmXbYYwP9kTu9tSp33CeDuoBE3ZcpeL3BOGa
         JXtB81TmCpJPW0zcOHVGJNX/NszEQkvZfOJg+j76YjZhpKda8mRVbpsJlEkDgDDcSlaH
         RIoZnzJL4uw6x4hLx9R29+Ek4smNaYfo66Nsu3mhc5EWcY6YtIY5mtrNGMRGRtns1YqC
         M7lqKuRArwb62IY6qPCQ3iuuzxi9taWjPDSYEOW9KzVYBH3ctxzjPlvkUkAnTiXXfpQl
         iiQg==
X-Gm-Message-State: AOAM533udF5SESfXZbIH7UlGz0M3AHE4Y8INuVrzA4BAdCz6nDuo9kI+
        VUOfPkch11EVomqSRIEHdtwX95Z2B3Aetg==
X-Google-Smtp-Source: ABdhPJw22cm4paYWTHsws6m7CufyMAPYiQCVHl56kPEf8JqC/4pM0t+Y0taBnyJdFRe1rm+0BPkuPQ==
X-Received: by 2002:a02:b1cd:: with SMTP id u13mr12089753jah.111.1635588201913;
        Sat, 30 Oct 2021 03:03:21 -0700 (PDT)
Received: from ircssh-3.c.rugged-nimbus-611.internal (80.60.198.104.bc.googleusercontent.com. [104.198.60.80])
        by smtp.gmail.com with ESMTPSA id s12sm228221iol.30.2021.10.30.03.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Oct 2021 03:03:20 -0700 (PDT)
Date:   Sat, 30 Oct 2021 10:03:19 +0000
From:   Sargun Dhillon <sargun@sargun.me>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, willy@infradead.org, arnd@kernel.org,
        Willem de Bruijn <willemb@google.com>
Subject: epoll may leak events on dup
Message-ID: <20211030100319.GA11526@ircssh-3.c.rugged-nimbus-611.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I discovered an interesting behaviour in epoll today. If I register the same 
file twice, under two different file descriptor numbers, and then I close one of 
the two file descriptors, epoll "leaks" the first event. This is fine, because 
one would think I could just go ahead and remove the event, but alas, that isn't 
the case. Some example python code follows to show the issue at hand.

I'm not sure if this is really considered a "bug" or just "interesting epoll
behaviour", but in my opinion this is kind of a bug, especially because leaks
may happen by accident -- especially if files are not immediately freed.

I'm also not sure why epoll events are registered by file, and not just fd.
Is the expectation that you can share a single epoll amongst multiple
"users" and register different files that have the same file descriptor
number (at least for purposes other than CRIU). Maybe someone can shed
light on the behaviour.

(FWIW: On closing of all references the file, the callback finally occurs
clearing the event)

#!/usr/bin/env python3
import select
import socket
import os

n = 2
sockets = []
epoll = select.epoll()

for i in range(n):
        sockets.append(socket.socket(socket.AF_INET6, socket.SOCK_DGRAM))
        sockets[-1].bind(('::1', 0))

for i in sockets:
        epoll.register(i)

clones = [os.dup(i.fileno()) for i in sockets]

epoll.poll()
# Returns: [(4, 4), (5, 4)]

for i in clones:
        epoll.register(i)

epoll.poll()
# Returns: [(4, 4), (5, 4), (6, 4), (7, 4)]

socket0name = sockets[0].getsockname()
socket0fileno = sockets[0].fileno()
print(f'Closing {socket0fileno}')
os.close(socket0fileno)

epoll.poll()
# Returns: [(4, 4), (5, 4), (6, 4), (7, 4)]

badsocket = socket.socket(socket.AF_INET6, socket.SOCK_DGRAM)
badsocket.sendto(b'test', (socket0name[0], socket0name[1]))

epoll.poll()
# Returns [(4, 5), (5, 4), (6, 5), (7, 4)]
# Indicating fd 4, and 6 have events.

# Oh whoops, I forgot to unregister 4...
epoll.unregister(4)

# Returns:
# Traceback (most recent call last):
#   File "<stdin>", line 1, in <module>
# FileNotFoundError: [Errno 2] No such file or directory


print(open(f'/proc/{os.getpid()}/fdinfo/{epoll.fileno()}').read())
# Returns:
# pos:  0
# flags:        02000002
# mnt_id:       15
# ino:  10994
# tfd:        5 events:       1f data:                5  pos:0 ino:30ffc5 sdev:8
# tfd:        7 events:       1f data:                7  pos:0 ino:30ffc5 sdev:8
# tfd:        4 events:       1f data:                4  pos:0 ino:30ffc4 sdev:8
# tfd:        6 events:       1f data:                6  pos:0 ino:30ffc4 sdev:8



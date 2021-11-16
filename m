Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA201452D47
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 09:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbhKPI62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 03:58:28 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:40478 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbhKPI6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 03:58:07 -0500
Received: by mail-io1-f69.google.com with SMTP id d12-20020a0566022d4c00b005ebda1035b1so8040080iow.7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 00:55:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=7QbZpkKxwpRPxmKh/zotEb1ntcjxK9f6n+KVl3zvQ5Y=;
        b=uNRu4HwJNEDOqhjZ81UtCv2ZONxYc3K3U/kjo8w38WuA13g8rygj27p3PYx4EsUMEA
         T7chGHANTNZmg/h6PnF3kB3Bq8ChOp0YFSi9mNYi9/VOQa9Jp/U83S63D2s4375PvBRo
         QxLl+t4LDK0b7+RGei7/16OlOQQGcAi1zSggtE9AgLNBheCBGHkC/7sieIyohnkFZNr9
         vV6Hj1J7mFSdESmUZiBYeHveUiZRv+1n4ibzplMJq16az1rUengAvPmevOzncZIodVIy
         EEqxStMJd8m8F/QTt5p9nLh+FSAxDA3g//4VyROI7bOnKHY1lJ/gfO6J72OJBYmCsZBV
         q4sg==
X-Gm-Message-State: AOAM533U4d+4H2BYg3IdRg1l/XY0bie1saMhGCxZchIHFbLBQTJJ4oaQ
        NrV3VbcMJRKBRyrhRfmsRz00Hj6TOIlm17XZ9tgXNQj+B9tX
X-Google-Smtp-Source: ABdhPJz8i0tba5Bs6/W20h3Di46eh44/GAF7pNDWP2hjSQmDmIugUmkyfqSFbUE+zqJhA5BJlpnjHUmyoMkqUxU7a3ViT7swpfep
MIME-Version: 1.0
X-Received: by 2002:a05:6602:29c6:: with SMTP id z6mr3623011ioq.215.1637052909858;
 Tue, 16 Nov 2021 00:55:09 -0800 (PST)
Date:   Tue, 16 Nov 2021 00:55:09 -0800
In-Reply-To: <5631140.hc6UrLtR2d@localhost.localdomain>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002bba5e05d0e415ee@google.com>
Subject: Re: [syzbot] BUG: sleeping function called from invalid context in __might_resched
From:   syzbot <syzbot+5f47a8cea6a12b77a876@syzkaller.appspotmail.com>
To:     elver@google.com, fmdefrancesco@gmail.com,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/---: failed to run ["git" "fetch" "--force" "f569e972c8e9057ee9c286220c83a480ebf30cc5" "---"]: exit status 129
error: unknown option `-'
usage: git fetch [<options>] [<repository> [<refspec>...]]
   or: git fetch [<options>] <group>
   or: git fetch --multiple [<options>] [(<repository> | <group>)...]
   or: git fetch --all [<options>]

    -v, --verbose         be more verbose
    -q, --quiet           be more quiet
    --all                 fetch from all remotes
    --set-upstream        set upstream for git pull/fetch
    -a, --append          append to .git/FETCH_HEAD instead of overwriting
    --upload-pack <path>  path to upload pack on remote end
    -f, --force           force overwrite of local reference
    -m, --multiple        fetch from multiple remotes
    -t, --tags            fetch all tags and associated objects
    -n                    do not fetch all tags (--no-tags)
    -j, --jobs <n>        number of submodules fetched in parallel
    -p, --prune           prune remote-tracking branches no longer on remote
    -P, --prune-tags      prune local tags no longer on remote and clobber changed tags
    --recurse-submodules[=<on-demand>]
                          control recursive fetching of submodules
    --dry-run             dry run
    --write-fetch-head    write fetched references to the FETCH_HEAD file
    -k, --keep            keep downloaded pack
    -u, --update-head-ok  allow updating of HEAD ref
    --progress            force progress reporting
    --depth <depth>       deepen history of shallow clone
    --shallow-since <time>
                          deepen history of shallow repository based on time
    --shallow-exclude <revision>
                          deepen history of shallow clone, excluding rev
    --deepen <n>          deepen history of shallow clone
    --unshallow           convert to a complete repository
    --update-shallow      accept refs that update .git/shallow
    --refmap <refmap>     specify fetch refmap
    -o, --server-option <server-specific>
                          option to transmit
    -4, --ipv4            use IPv4 addresses only
    -6, --ipv6            use IPv6 addresses only
    --negotiation-tip <revision>
                          report that we have only objects reachable from this object
    --filter <args>       object filtering
    --auto-maintenance    run 'maintenance --auto' after fetching
    --auto-gc             run 'maintenance --auto' after fetching
    --show-forced-updates
                          check for forced-updates on all updated branches
    --write-commit-graph  write the commit-graph after fetching
    --stdin               accept refspecs from stdin




Tested on:

commit:         [unknown 
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git ---
dashboard link: https://syzkaller.appspot.com/bug?extid=5f47a8cea6a12b77a876
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=131e6221b00000


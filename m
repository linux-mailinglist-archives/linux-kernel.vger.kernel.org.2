Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2CED3B5A49
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 10:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbhF1IOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 04:14:19 -0400
Received: from mail.monom.org ([188.138.9.77]:37530 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230294AbhF1IOD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 04:14:03 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id 00FBD50051C;
        Mon, 28 Jun 2021 10:11:36 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.monom.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.2
Received: from localhost (unknown [94.31.100.41])
        by mail.monom.org (Postfix) with ESMTPSA id BBC2A500143;
        Mon, 28 Jun 2021 10:11:35 +0200 (CEST)
Date:   Mon, 28 Jun 2021 10:11:35 +0200
From:   Daniel Wagner <wagi@monom.org>
To:     Mike Galbraith <efault@gmx.de>
Cc:     John Kacur <jkacur@redhat.com>,
        RT <linux-rt-users@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Clark Williams <williams@redhat.com>,
        Daniel Wagner <dwagner@suse.de>,
        Johnathan Schwender <schwenderjonathan@gmail.com>,
        Peter Xu <peterx@redhat.com>
Subject: Re: [ANNOUNCE] rt-tests-2.0
Message-ID: <20210628081135.l7yvya7iaygb23ye@beryllium.lan>
References: <20210625160801.9283-1-jkacur@redhat.com>
 <549a4a5579068b9b1ca7741cb0f4aafbd04f4389.camel@gmx.de>
 <1c1966dd51ae6f8ddcd892cba485c332281fbd37.camel@gmx.de>
 <3d6a6c593eed6f5d59209ba2d8db29fadcc72ad7.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d6a6c593eed6f5d59209ba2d8db29fadcc72ad7.camel@gmx.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On Sat, Jun 26, 2021 at 02:45:27PM +0200, Mike Galbraith wrote:
> On Sat, 2021-06-26 at 13:47 +0200, Mike Galbraith wrote:
> > On Sat, 2021-06-26 at 08:55 +0200, Mike Galbraith wrote:
> > > On Fri, 2021-06-25 at 12:08 -0400, John Kacur wrote:
> > > > I'm pleased to announce rt-tests-2.0
> > >
> > > Greetings,
> > >
> > > cyclictest seems to have grown an mlock related regression.
> >
> > Ok, chores done, I did a quick bisect/confirm.  I didn't go stare
> > at rt_test_start() to ponder what the mlockall connection may be.
>
> Moving the call above "Get current time" stops it mucking things up.

Thanks a lot for your excellent report. rt_test_start does

  static char ts_start[MAX_TS_SIZE];

  static void get_timestamp(char *tsbuf)
  {
          struct timeval tv;
          struct tm *tm;
          time_t t;

          gettimeofday(&tv, NULL);
          t = tv.tv_sec;
          tm = localtime(&t);
          /* RFC 2822-compliant date format */
          strftime(tsbuf, MAX_TS_SIZE, "%a, %d %b %Y %T %z", tm);
  }

  void rt_test_start(void)
  {
          get_timestamp(ts_start);
  }

I'd say the tsbuf access is the one which triggers a pagefault.

John, I would suggest to move the rt_test_start() into rt_init() and
take the timestamp at the execution start (as my initial version was). I
think the additional pain in slightly more correct start timestamp
(which is also not defined what it actually means in this context) is
just not worth the effort.

Thanks,
Daniel

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECF4399F86
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 13:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbhFCLJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 07:09:57 -0400
Received: from mail-qt1-f179.google.com ([209.85.160.179]:37815 "EHLO
        mail-qt1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbhFCLJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 07:09:55 -0400
Received: by mail-qt1-f179.google.com with SMTP id z4so1009948qts.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 04:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uged.al; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hrHbY4jfA5cFkMPe6epePm+cTph88KbJNp2s/M2Oe5Y=;
        b=WRdPlw+dNnAaWrStFtYwKQ3BH33NadyE6JHZr817Vu7/8n7CpsLkVL5E1+M/1O6B2e
         cyD1P5t4YcaD6ngaSRiE+7C00fwcmqs72jDdHkHNBgeXdecs8LI6Yk79M2bGIALhLUzv
         v7ixWINXt9bD7V62PcWKt81zlZVZ5TK6hcBpnLFk9NOSTEToR5hB45bpNqpbPbcE55yi
         fOE6OnQKCKiNBYeAUmIuygKp2CiZwNS4DrXoANhClVwf3XpzJSkS3V6n2Ov32JTfSZ5E
         dVvuh30o+DHDYKs62hO8olXHCILx/0OJJIzJH/dpLxPo9K7PvKHY29ngwZSUDvgqIaVd
         SZ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hrHbY4jfA5cFkMPe6epePm+cTph88KbJNp2s/M2Oe5Y=;
        b=QVPTcetIT+uekpMTE2BbJ0sIKPkiSlOI1M9MnXRPlB+pe5x0yaty2jUyShZAqsUcha
         boFGUAZZFi+Py8JuwosTtXNqP3NrFr7vQ0a3LWAMoSJmXj0UOnO9sZX8bf8bcD7Lvzxc
         s4Zr1GV4pKmMJTA7tpSvZCHPwOjMfK1Kpv/Om8DWqGUWMYJOUdM7Z7uSt0/1wLMI/twG
         q2QroLqzrLyqoZna+5MziN5bccC3t0BEBK0jQCK0ftELJAYi2m18Z1X4s6inyspbbwFp
         CZBlYo3XYIC38Sh3s+Sy4UblpRFCAD80M7UJOA8/fkV4wE7aWCOhx9oiYXQrQV/TPpEw
         LBhQ==
X-Gm-Message-State: AOAM530O9RRZnMvMql5ydlLfQNifKXuDlhMC9d/iccUvVPKpTccAHU+9
        z6proOILs2GzThATI1/LL7eUBVb5P4xspme+h6W0ug==
X-Google-Smtp-Source: ABdhPJx0PrW7jwpCbpHMBOLd8LbpetKi8KnoiI5QfLJ+igCaNZEvQBIHqDndfxKAKMNOth88p6eXEHbg0gq6mGVCStY=
X-Received: by 2002:a05:622a:202:: with SMTP id b2mr28180373qtx.343.1622718418418;
 Thu, 03 Jun 2021 04:06:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210601155328.19487-1-vincent.guittot@linaro.org>
In-Reply-To: <20210601155328.19487-1-vincent.guittot@linaro.org>
From:   Odin Ugedal <odin@uged.al>
Date:   Thu, 3 Jun 2021 13:06:19 +0200
Message-ID: <CAFpoUr0NUVqxCtRefu+MUv=SSA+7ie5OxtPqYZ=AT=JNc+0t=Q@mail.gmail.com>
Subject: Re: [PATCH] sched/pelt: check that *_avg are null when *_sum are
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        Odin Ugedal <odin@uged.al>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Is there an idea to add tg_load_avg_contrib as well, to avoid
regressions where that is not set to zero?

Otherwise:

Acked-by: Odin Ugedal <odin@uged.al>

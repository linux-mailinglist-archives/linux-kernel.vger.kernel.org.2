Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3356E39A351
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 16:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbhFCOgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 10:36:15 -0400
Received: from mail-qk1-f172.google.com ([209.85.222.172]:41814 "EHLO
        mail-qk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbhFCOgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 10:36:14 -0400
Received: by mail-qk1-f172.google.com with SMTP id c124so6093581qkd.8
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 07:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uged.al; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jek8VYrbUTgHu6rDeQso6jW7gqcwx9N8LPcpEzUt7zY=;
        b=XsCT8l1vXpcjpdoebJzxf/T/7Fg0kAZ+uNm4zeMDVBnKN3ojDYMDQLAokyN8wE2wjJ
         dlZLf5u40xayTn0lLvo5jQaZoFdypbXovNeVzMbdEjz4aaBntqhGMiIBUg1xMnRtlTFe
         Oyf483WZEeLVkYM+xOz7pjmlflC+ypDrx9ISy0tjlQd94F/5FC3uwFgMXg/A5Vzq2tbL
         Hqi7WZRck82ueCFQkP53OOwPzCz0ZqldND0FkvUs08PCBomYGQGMMceEGOyz83DM6lFh
         aQn+FeWZIQpkX8bgvJN6pn6diDQDUZNc17CijMRmypKPtzrmguQggRWnEF3hOm58l1ef
         Muiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jek8VYrbUTgHu6rDeQso6jW7gqcwx9N8LPcpEzUt7zY=;
        b=Li4XYuQ6d+eRNBrzBh51JBstN/KxDQQGXizu0tPQpsz+zMTQsPWfg2Y8SJRdl1OSzF
         T49v+GF8Ose6zurRnEHsJs3yqOaoZNPBB8gwqITTzyvvmKjbCDw4BCPbtOvabT20fyN2
         IemorAgvCdkeBPjoKHP9GLe1uN3Ey1zDAmdvUIBBwJw7/LmK22rtVGwGgI0RVRHziyjM
         gSkHAupP4kXlSIzDJORy4f8i1PA+5lR/f8U9Z9AAxNKzRkFCVSxzpginVEN1non4yqSS
         qCABcvwwfa45xagG6XI1j9lAMBSgxA1gCAoq/JQT8zWRkikuaWXTd2hmRv40R3bKlvnA
         u8VA==
X-Gm-Message-State: AOAM533RM9n6fWtfeFyDzQI26eUc6DLwDi+5M8iTGenkKaRQbiAAB6QR
        kY6gowvZi+qOkxmUn7o2ysudmMypXEl30edZ2ieydl3n8BycOQzDzTI=
X-Google-Smtp-Source: ABdhPJwNLi3hDGRJANixcTJY805m7TKf1Zhk2pOqWKyfRpByhVG0KXAc5JmjDHGSd2ZtwL58CpGB4cYzCMbZX9QZ2CQ=
X-Received: by 2002:a05:620a:56a:: with SMTP id p10mr32786793qkp.238.1622730809606;
 Thu, 03 Jun 2021 07:33:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210601155328.19487-1-vincent.guittot@linaro.org>
 <CAFpoUr0NUVqxCtRefu+MUv=SSA+7ie5OxtPqYZ=AT=JNc+0t=Q@mail.gmail.com> <CAKfTPtCDPGJW=J6JmZ+Gs5kcptfWUwAsFs=xyCcoJ_hF--EkAA@mail.gmail.com>
In-Reply-To: <CAKfTPtCDPGJW=J6JmZ+Gs5kcptfWUwAsFs=xyCcoJ_hF--EkAA@mail.gmail.com>
From:   Odin Ugedal <odin@uged.al>
Date:   Thu, 3 Jun 2021 16:32:50 +0200
Message-ID: <CAFpoUr01WeUEaE=Md3WVtgWbZv+8Vuz23ad-ucqeSW5g7fKsRg@mail.gmail.com>
Subject: Re: [PATCH] sched/pelt: check that *_avg are null when *_sum are
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Odin Ugedal <odin@uged.al>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> TBH I wondered while preparing this patch if tg_load_avg_contrib
> should be checked as well but I came to the conclusion that we should
> keep this looking at PELT metrics only. If tg_load_avg_contrib != 0
> but load_avg ==0, it means that we failed to update
> tg_load_avg_contrib somewhere else

Ahh, that sounds good. Agree.

Thanks
Odin

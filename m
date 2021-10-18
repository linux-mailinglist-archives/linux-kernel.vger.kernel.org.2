Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C31924328B9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 23:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233893AbhJRVDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 17:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbhJRVDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 17:03:14 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89320C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 14:01:02 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id x207so9306434vke.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 14:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LBWXJiOY2N3UDtzoeZIPjHRlsPyA16TTeIu0O7GzSI4=;
        b=Anl+k1o3nihkiSIRW1EeoneU5y2dYM+LiPjxtjRW5YeNJxZGjWLMOJjGwAkUekQrkr
         FqVCumJk5+eOCrYBTZZzYCY2lv22qUt0VpJdxBJ9eIuboVpfjbjYuk6g6fjXZmBLUCP2
         6ON3dvXwluxOjmmXqmGwhA0wBDNVA8VKNEafrGhLnkm0LtB1uT+pG6TU7XdWwPdwWZxw
         jfi1bJNgQFHuifNnrg3/yrpEvRxR8ZKWMlG0nKnELvBiZXIGXED1csXE1SuEtlVSLH7H
         7z6w+1mOw04aij6wUIT87TTQZdqTYI4xmyxT5MgVLUBSXXC3qOpZIhFj473rYnJu2JmT
         Yz/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LBWXJiOY2N3UDtzoeZIPjHRlsPyA16TTeIu0O7GzSI4=;
        b=P9qaKcN1GcKV+TnAmY7SaN6V5FZLE8BBRLK6VKWkFbyUeBigH8OphFEgdSm52+bLO2
         KdqDwkCY46IBRHEXAqk+d3aWTG0fAaJhs6lBVxSD5xG1FpCrndLPE01Lzyk2J8yDdi3T
         lJX0wRU84fKr6uL9QmqhnlGy5QIlnPMwcPEy/rt0FSBIYUf3xm7YFhFqtdBpmiE+LetB
         9+3LmBZNj6+jFt24EQ5FHtxd/4LUAA/r5vLSE9GOCo4PITLF7OJezw/eLKlnjzNVnZZi
         OvXN4Sv6XHfv84E7bPaTV8dM3l5D9L5rn+1moAAXDVCOFVukmajFxGusJVY0Uy80juEH
         YOzg==
X-Gm-Message-State: AOAM5324Q6gAi4YX5M8ZQ4fiOeqWJF5iYJY7NAMiaTnGfpwQHTZXCfoB
        18b3JtXeNv7ej0Vq0VKpeJJ1m/dWXuX83/0d28AA3Ywmt94=
X-Google-Smtp-Source: ABdhPJxdStWsA9KUl2nJOjMRt/FnLFB9h0hI/38FN/HmiiatW4gPRk7f179qSQdpTwCRbDNnUKr/i5dTEtxGAYFP6O8=
X-Received: by 2002:a05:6122:201f:: with SMTP id l31mr27705980vkd.22.1634590861609;
 Mon, 18 Oct 2021 14:01:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAD-N9QWd6Orm8d9AMk7mybByAKZod=GJ-HSNPOfhFDStSPwSUA@mail.gmail.com>
In-Reply-To: <CAD-N9QWd6Orm8d9AMk7mybByAKZod=GJ-HSNPOfhFDStSPwSUA@mail.gmail.com>
From:   jim.cromie@gmail.com
Date:   Mon, 18 Oct 2021 15:00:35 -0600
Message-ID: <CAJfuBxz6-cF6pYNS0-o_xixoKBzBn5AuXTNOW3x20rXo4Ox5Cw@mail.gmail.com>
Subject: Re: Any tracing mechanism can track the executed instructions of a
 user process in the kernel?
To:     Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     kernelnewbies <kernelnewbies@kernelnewbies.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Pavel Skripkin <paskripkin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 17, 2021 at 8:46 PM Dongliang Mu <mudongliangabcd@gmail.com> wr=
ote:
>
> Hi all,
>
> I am writing to kindly ask one question: is there any tracing
> mechanism in Linux kernel that can trace all the executed instructions
> of a user process? If this user process is run on different
> processors, traces of this process on different processors should be
> also recorded.
>
> Any comment is welcome.
>

take a look at rr-project.org

what rr does

rr aspires to be your primary C/C++ debugging tool for Linux,
replacing =E2=80=94 well, enhancing =E2=80=94 gdb. You record a failure onc=
e, then
debug the recording, deterministically, as many times as you want. The
same execution is replayed every time.

rr also provides efficient reverse execution under gdb. Set
breakpoints and data watchpoints and quickly reverse-execute to where
they were hit.

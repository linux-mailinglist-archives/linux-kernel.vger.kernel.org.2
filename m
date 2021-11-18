Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 282A0455CC7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 14:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbhKRNhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 08:37:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:60618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231420AbhKRNhD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 08:37:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 46AA56140D
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 13:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637242443;
        bh=0ivQJzVzui4MmwVgZ8hpY5e30FitxB1fn4ngg2LjTFM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eY7IpajSbkICMs8va3RvD5zJy8GE5QH6EWzgflZPzioyzqR89I7zeJ2FXx3dXy8D8
         FhFCTAFdxbKp3bvNOfhkJz0Y+xjfffIxjQwGyB24PLEY77ZZOUWfFnkryu5IVsh8zP
         oIAo1T3BuB0zfTvBa3ZbdpOn6TDxNqOSpavS/uWPDLlziD7OTt2buS7elUkkffzEpq
         GzTrwM+JDc3yhJ8SzoWF+vDULiwQm+112CCObJsC/X4L2tu7+onIs8QjNaF7IEWBAC
         Rw/l5InSq6D7S/+RHrt3cj69MZNOWqYHb8tX9fav9xRMDJQuZC64sfLXOo4HpuzKEO
         iXkJ98dCAa6aA==
Received: by mail-wr1-f46.google.com with SMTP id i5so11647697wrb.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 05:34:03 -0800 (PST)
X-Gm-Message-State: AOAM532FgBUvgQHaewMH96cx5OTjVrsSj/ByJp8voIxrZcTbHfkmF8eP
        tVHNLQ8Kb5ucdR/NUnELvvfV+zhHJgvp5yT6qlI=
X-Google-Smtp-Source: ABdhPJyaUK/Ojy7DSBYbAR0aPoS6sB6RDNQxLobpvm80W8uUqqGn8ZOZtD+x56mwKpf4ZqG6Tc+h4uHQt1BfUkQ4Eaw=
X-Received: by 2002:adf:f7c2:: with SMTP id a2mr32000504wrq.71.1637242441723;
 Thu, 18 Nov 2021 05:34:01 -0800 (PST)
MIME-Version: 1.0
References: <20211115223911.982330-1-daniel.lezcano@linaro.org>
In-Reply-To: <20211115223911.982330-1-daniel.lezcano@linaro.org>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 18 Nov 2021 14:33:45 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0fLzjFSHRDHT7-eEnk0+E4zPrk-_g53ROs_dmyc3g1EA@mail.gmail.com>
Message-ID: <CAK8P3a0fLzjFSHRDHT7-eEnk0+E4zPrk-_g53ROs_dmyc3g1EA@mail.gmail.com>
Subject: Re: [RFC] DT: bindings: Powerzone new bindings
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Rob Herring <robh@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rafael Wysocki <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 11:39 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> The proposed bindings are describing a powerzone, a power capping
> capable place to act on and where we can read the power
> consumption. The powerzone semantic is also found on the Intel
> platform with the RAPL register.
>
> The powerzone can also represent a group of children powerzones, hence
> the description can result on a hierarchy.
>
> The description gives the power constraint dependencies to apply on a
> specific group of logically or physically aggregated devices. They do
> not represent the physical location or the power domains of the SoC
> even if the description could be similar.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Hi Daniel,

This looks reasonable to me, based on what I remember from previous
discussions, but it would be good if you could summarize the points that
have already been discussed in the past, e.g. which approaches you have
tried out before and how you ended  up here, including links to mailing
list archives.

I know you've been at this for quite some time now, but I can never
remember the bits that we discussed in the past myself.

        Arnd

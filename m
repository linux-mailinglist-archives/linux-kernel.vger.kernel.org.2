Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9DE38B838
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 22:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239929AbhETUT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 16:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233159AbhETUT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 16:19:56 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC5EC061574;
        Thu, 20 May 2021 13:18:32 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id s6so20802561edu.10;
        Thu, 20 May 2021 13:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yiN+nJM5afs1OG+wImwlgCn2IyQHVphWRabagEo0dzQ=;
        b=QSGvHqzhGYJ4117Wqeq8ym6kwRhKgpJqNuh6Bvx8zZ0kLJifGJbY5egYAe4aJZmzXb
         nX242ZRJzpWZN77DMgaY0D7g/lhMHmt/716EAIr4mjMIQf9MJpvBEVAO+FHf4HYTrrL1
         TuZPO+xs6iVdZYaXEEzpnqWfBUwsrJk5bbrRlAZx3JYFUzs0tLw2INE2fWL9ADmtyznQ
         iUle1zltt8OvTEMAe7rnfRtjlpK4hQjvnEF2PVZ5OBFfhok+obxgKZrDAhD6nyw8POmH
         tNAY68O/j8Ox/wSjCyYTL8mm4xw2ZEwU6nuj4U2VVpxXHl1t9qs0jUczgAoLgpJlDB3m
         Vwag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yiN+nJM5afs1OG+wImwlgCn2IyQHVphWRabagEo0dzQ=;
        b=rfmSvVr85L83spHO/JBOhS+bvfgRqbQsCcPOsdgW2ugvuO4pVi/xdeu+0K11/TJ3PG
         QF1CDLcduQ/oYxMQe2dY4e6d00dNMGg3vHxU3/KaqRfz09VC80ZmSz/yB/bPYjTpbdWL
         VADDu99jIoI1PBgWln3yFAKuk18yKwlhqrtw+UTDwgl9dvHFGUJ77F5HFxISDGHNzmkR
         g9qvEk+UVHT40RKY/74DkFa3m77v71z+opjQPzAtB6YaJbs/0w4TDdJ3HLYbBmiWa6SU
         TJinmZgFFcmvcS0yr7ETaX5kOZ9xt2NAsKarq4donGhSElr7ONdBxqbT3fDK8ODQmY52
         4s6A==
X-Gm-Message-State: AOAM532w4pcjOfvfjsZQ0r2hY3n7zVFTo+42JdmYUhG8OZ5LQbXUB9j7
        9NmACNc8jwx4sykPYL/3xVP9C97H+AAl0bip1BKxecfO44E=
X-Google-Smtp-Source: ABdhPJybuLLiK/78YthsNpjiYoeKG9AfUVaCV5etxUAmLyjkMi3piYNmFQTmaU4a4YpzM7zukNVg4eVG9cgUxSq9B3M=
X-Received: by 2002:aa7:dc12:: with SMTP id b18mr6789458edu.52.1621541910921;
 Thu, 20 May 2021 13:18:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210520073136.272925-1-jbrunet@baylibre.com>
In-Reply-To: <20210520073136.272925-1-jbrunet@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 20 May 2021 22:18:20 +0200
Message-ID: <CAFBinCB=pAipcZOi8S005SyO8ptfzy8oGpW4S8Pi++A5-Jc5eA@mail.gmail.com>
Subject: Re: [PATCH] clk: meson: axg-audio: improve deferral handling
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 9:32 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> Use dev_err_probe() for clock and reset resources to indicate the deferral
> reason through sysfs when waiting for the resource to come up.
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

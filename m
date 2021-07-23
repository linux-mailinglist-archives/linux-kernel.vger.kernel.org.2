Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBE5B3D318C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 04:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233165AbhGWBjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 21:39:24 -0400
Received: from mx-lax3-3.ucr.edu ([169.235.156.38]:11402 "EHLO
        mx-lax3-3.ucr.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233166AbhGWBjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 21:39:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1627006784; x=1658542784;
  h=mime-version:references:in-reply-to:from:date:message-id:
   subject:to:cc;
  bh=r2k/ZyHXET6YwtDazCGjya0qD1Yvk7/99us7wWTBBGY=;
  b=KskBHZSYzHU+m1bkyU8GuvljyjeWbFepQaHbN2yTHp/xY2972v5hFgav
   S7iwKnKeCfPBLdiunEQY3XR2f508/msTMAGjJWiM6iu8u7Docr5zlA6ho
   ukTZuwkSRl070syGjtz5uWATs1EGdD3VgI1cOVOFYxBnsXtvKCFNfSyQp
   g7hwZNHeizUXpJaRQNYuRstEXcUYh3zXoWX/QkT7No4+b+L4mFP5qGE0q
   yiarBt8JwY9tqmACzV3LcB1SjP/mrM+OEYlu9DV2oQCpvjlwFyG5BSFrw
   nkSfEMlXRWhfvHzQWr7sMnFjcsFD7Vl7jZLTVo5WrLig2fu+VNE4iR8Ny
   A==;
IronPort-SDR: 17o2gAHIFPNtvs+ijLrcFo7rfcirt2/CTnlc1wb9HdUese95zPQB0Uq40iLizsNVhGLPOFk1Fz
 KLCS0ICcpNz/18su2HH0NGd9/BrEqOPzQQvu3n7ePKLPhQbcNamx0xqAwoz4naL9xogWeys38m
 ps/gQOQgAdRYr+wn4y0XS6iCS8c2bhKxVTFdENiCtit8zoWapc+4qNno36F6euF0KUatsDrLQP
 ycwGDjnMj492KcETpmD5tooqJFveP4Mpf2X3ohFS1MGWqiyQ2VSpTL+H027Zi3mbYNvnR3CGpc
 8vMleRULglfR/y6n1/PScjrO
X-IPAS-Result: =?us-ascii?q?A2FZAwDpJvpgf0bYVdFaHgEBCxIMQIFOC4N4bIRIkWqHD?=
 =?us-ascii?q?JRSgXwCCQEBAQ9BBAEBhFcCgngCJTQJDgIEAQEBAQMCAwEBAQEBAQMBAQYBA?=
 =?us-ascii?q?QEBAQEFBAEBAhABAYEMC1kLY4FPgXkGBD2COCkBg20BAQEDEhFLCxALCwMKA?=
 =?us-ascii?q?gImAgIiEgEFARwGEyKFV5xngQQ9izKBMoEBiBsBCQ2BYxJ+KocKhmIngimBS?=
 =?us-ascii?q?4I/MD6HW4JkBINOgTiCA0VWAQEBnxOdDgEGAoMMHJJEi3org1GRbJEmuy8QI?=
 =?us-ascii?q?4E9ghUzGiVOMQZngUtNAQIBAgEMAgECAQIBAgECCAEBAp0LJC84AgYLAQEDC?=
 =?us-ascii?q?Yt5AQE?=
IronPort-PHdr: A9a23:H5IOrhcCDVXVxFmXxNvl+CZNlGM+v97LVj580XLHo4xHfqnrxZn+J
 kuXvawr0AWRG96EoK4aw8Pt8InYEVQa5piAtH1QOLdtbDQizfssogo7HcSeAlf6JvO5JwYzH
 cBFSUM3tyrjaRsdF8nxfUDdrWOv5jAOBBr/KRB1JuPoEYLOksi7ze+/94PPbwlSijewY7x+I
 Rq3oA7MqsQYnIxuJ7orxBDUuHVIYeNWxW1pJVKXgRnx49q78YBg/SpNpf8v7tZMXqrmcas2S
 7xYFykmPHsu5ML3rxnDTBCA6WUaX24LjxdHGQnF7BX9Xpfsriv3s/d21SeGMcHqS70/RC+v5
 Ll3RhD2lCgHNiY58GDJhcx2kKJbuw+qqxhmz4LJfI2ZKP9yc6XAdt0YWGVBRN5cWCNPAoy+b
 4UBAekPM/tGoYbhvFYOsQeyCBOwCO/z1jNFhHn71rA63eQ7FgHG2RQtENAPsHXVrNX1KaASW
 v22w6nI1zrDbu5d1DD96YnJchAuu/CMUa5sfcff0kQvCh/Kjk+KpYP7IjyVy/0Avm6G5OVvS
 eyhkXQoqx1tojex3McsjJHEi40Rx13A9Sh3zpg5KNK8RUB0YtOpH5VduiGUOoZqQ84vX2Blt
 Sg5x7EbpJO3YSsHxYopyhPQaPGKboaG7w//WeuXPDx2h2pldaqhixqu9UWs0O7xW8mu3FpUs
 yZIk8PAu3IR2xHV98OJUOFy/l271jaKzw3T7+ZELl0qmqfDMJ4hx6IwloIUsUTeAi/6gEX2g
 7GSdkUj4uWo7v7oYrTippOFL490iBzyPr0gmsG9Heg0KAcOX2+c+eSz0L3s41f1T6lNjv0zi
 qXZsZbaKtoHpqOhHQNZzoIu5wy8AjqmytgUg2QLIVNfdB+Fk4TlI1TOL+r5Dfe7jVSsijBrx
 /XeM7zhA5TNLmLMkLb9cbph5UNR0xczwsxF555OFL4OPe/zVlfrtNPEFh85LxC0w+H/BdV51
 4MeX3+PA6CAPKPRr1CI/OQvLPeIZIIOpjb9JOYq5+T0gX86h1AdZ6+p0oUTaHyiGfRmOUqZM
 jLQhYI6DWoSvgc4BNbtlF2dXDpXLyKpUbgU7Tg9AsSvEJrMAIe3j/qIwXHoMIdRYzV3C0KMD
 HCgRYWNWr9YeTCSK845ymcsSLO7DYItyEf950fB17N7I7+MqWUjvpX52Y0wvrWL/Sw=
IronPort-HdrOrdr: A9a23:wLT5tK9lxN8w7SNrIjBuk+DjI+orL9Y04lQ7vn2ZhyYlC/Bw9v
 re5MjzuiWE7Qr5NEtQ++xofZPwIk80lqQV3WByB8bHYOCOggLBR72Kr7GD/9SKIVyYygcy79
 YHT0G8MrDN5JpB5/oSLDPWLz/o+rXozJyV
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.84,262,1620716400"; 
   d="scan'208";a="59243136"
Received: from mail-pj1-f70.google.com ([209.85.216.70])
  by smtp-lax3-3.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Jul 2021 19:19:43 -0700
Received: by mail-pj1-f70.google.com with SMTP id in8-20020a17090b4388b0290175556801d5so214745pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 19:19:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M5HsahaIutzaQX3vCMZAwzsw9akG1P42X3BuyLwQd9s=;
        b=mbYl1UVovJIMc2miVaA72shZ0opUt5X3INbCZpLQLttSk7Jlksvw13zUaYoeWLIYwi
         IBg3cIFzPJghWSbxhxq0YP3VTQFKq/hV9BJ6rw7JDrbAVD1f/KuxVeoZA1+qrKpCqJC5
         hri9B+mNmRvXNOyjx7ppy/7v0KSPtEIGN0KqH4rgTXNaOSf0pU+GsZ07WFZXrcUHZN0S
         1+yGOY60umLPe1M3KUPhjhHq8lQIktjFeyrWqyDgfvyRqtdTnA8F3CkVZywGVepTBFeh
         oyGBW2mdLzmHndtKkipyMyodLVGFZQcUbeDJ0iYgnyKhiTwrZdTSYt2Tkx6E+wvktPfe
         rlIg==
X-Gm-Message-State: AOAM533dYO54M3Gi5G0SkrVywW1kL407byKlz9aBj7mK6L8f+hfUv2B6
        i6KhZNCIihCoXwAcvHsi/eer0pQzcA4dSsAEzYIptUMaVn6E3oH71dP6pvTpSUvLYWm13OPNgry
        zwh3faduB7IwujgP8CwWyBULwtYxPU2CoKnWPmzY8Vg==
X-Received: by 2002:a63:d74c:: with SMTP id w12mr2766786pgi.91.1627006782724;
        Thu, 22 Jul 2021 19:19:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz5l17AKmOZX6WgLZL37UMyq1+sbJYLI+l+EBxxSDbeQUFmfB784kN/6E/+lkE37HoDW3vS+wmwqyPASgz3m50=
X-Received: by 2002:a63:d74c:: with SMTP id w12mr2766766pgi.91.1627006782497;
 Thu, 22 Jul 2021 19:19:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210723085145.1ce7ee5c@canb.auug.org.au> <CABvMjLTTtAwH7tT96TQ8THkCjTGUe-bMij449UALoyTSS94amQ@mail.gmail.com>
 <20210723105838.613c9020@canb.auug.org.au>
In-Reply-To: <20210723105838.613c9020@canb.auug.org.au>
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Date:   Thu, 22 Jul 2021 19:19:31 -0700
Message-ID: <CABvMjLS2pvX7L1euq_QF_nt7tq+22p0gahz88AYGRAb8dPb0gQ@mail.gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the v4l-dvb-next tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen:
Great, thanks.

On Thu, Jul 22, 2021 at 5:58 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Yizhuo,
>
> On Thu, 22 Jul 2021 17:38:13 -0700 Yizhuo Zhai <yzhai003@ucr.edu> wrote:
> >
> > Stephen:
> > It seems you are not in the maintainers' mailing list, should I send a
> > copy to you as well?
>
> No, that's fine, I will get the fix via the maintainer.
>
> --
> Cheers,
> Stephen Rothwell



-- 
Kind Regards,

Yizhuo Zhai

Computer Science, Graduate Student
University of California, Riverside

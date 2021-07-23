Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A46D83D30EE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 02:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232833AbhGVX5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 19:57:52 -0400
Received: from mx-lax3-3.ucr.edu ([169.235.156.38]:15393 "EHLO
        mx-lax3-3.ucr.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232730AbhGVX5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 19:57:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1627000706; x=1658536706;
  h=mime-version:references:in-reply-to:from:date:message-id:
   subject:to:cc;
  bh=garshgjdMJCMlsmeozlgmwx58jNaTBUCFx8jv84/gXE=;
  b=cnln+m2nEemlN+n4AZytaHGQ54PGrm16B47FBixYaROuRTA9JBo1MaYg
   aqOs2M2vg+VTkXNm7tH6jlOTjxTJfUeT1BEUa0V/hIRbnnXNlh1mvYarV
   02J3L8GjVqPZ+Wx1MEKdpgpwimyupiLtmRlJAEEwB/FeaE3t4/KT+HgAt
   6ay5FpaGHSpsfXDQeN3hZKYWIg4nBvVgBZspkZNuaeU0t+QGv1AW7RUCg
   q7Dxlu6h0OwScs82t3NS4m4p+WsmzF/5BWwMYjVns3KFinXPZHRqRrW8B
   +cnKq36cj+bMt0f0Kz3011UjxaGiOFwVVPYcqItc+FHocB7XK2OUFmIiC
   A==;
IronPort-SDR: mxibRdcZzqet9XOwMNXcsNtYDukJNouVv67Escngis9UPmPeP7eqwxmOQw/CnDAuKj9zyKbUBO
 ZjX1R4a6rsD0IB2Tsmpu04WKQygwnUDcuTUWiS9UzDk/hVtJyVgIXJHz9H6HwO7MFr6VJLN8mN
 ft7T71ZJf9nitvDOLYlY3zexj/gfSlFJbOo+P+l8UdFwi9GfKMjr9psqd1C7KK8txuQajr/F5O
 Qzde/J0vvHRDt86ZQLUyGEPR1u9LO3fnoSHy5/JaydBJxuCyX1U8uPIdpOtrC2oWc0tOkcyKTj
 UmED6zRTS/Hzm0jvzVMAw2ml
X-IPAS-Result: =?us-ascii?q?A2FEAABQDvpgf0bYVdFaHQEBAQEJARIBBQUBQIFFCAELA?=
 =?us-ascii?q?YN3bIRIiCSJRYcMlFKBfAIJAQEBD0EEAQGEVwKCeAIlNAkOAgQBAQEBAwIDA?=
 =?us-ascii?q?QEBAQEBAwEBBgEBAQEBAQUEAQECEAEBgQwLWQtjgU+BeQYEPYI4KQGDbQEBA?=
 =?us-ascii?q?QMSEUsLEAsLAwoCAiYCAiISAQUBHAYTIoVXnHaBBD2LMoEygQGIJAEJDYFjE?=
 =?us-ascii?q?n4qAYcJhmIngimBS4I4BzA+h1uCZASDToEpD4EWODVFVgEBAZ8TnQ4BBgKDD?=
 =?us-ascii?q?BySRIt6K5U9kSa7LxAjgT2CFTMaJU4xBmeBS00BAgECAQwCAQIBAgECAQIIA?=
 =?us-ascii?q?QECnQskLzgCBgsBAQMJi1kBAQ?=
IronPort-PHdr: A9a23:vRJenxQFsvyxgYm064BJHPIE99psorGfAWYlg6HPa5pwe6iut67vI
 FbYra00ygOTBcOAtLkc1KL/iOPJYSQ4+5GPsXQPItRndiQuroEopTEmG9OPEkbhLfTnPGQQF
 cVGU0J5rTngaRAGUMnxaEfPrXKs8DUcBgvwNRZvJuTyB4Xek9m72/q99pHNfwlEnjSwbLF9I
 Bmqrwjaq9Ubj5ZlJqst0BXCv2FGe/5RxWNmJFKTmwjz68Kt95N98Cpepuws+ddYXar1Y6o3Q
 7pYDC87M28u/83kqQPDTQqU6XQCVGgdjwdFDBLE7BH+WZfxrzf6u+9g0ySUIcH6UbY5Uim54
 qx1VBHnljsINz8h8GHWlMNwir5boAm8rBB72oLYfZ2ZOOZ7cq7bYNgUR3dOXtxJWiNODIOzb
 YsBAeQCM+hFsYfyu0ADrQeiCQS2GO/j1iNEi33w0KYn0+ohCwbG3Ak4Et0MsXTVrdX1NLoVU
 euoz6bIzS/Mb/JL0jr66InJcxAhruuNXb5sbcbcx1IiFx7ZgVWKs4DqIS6a1vkUvmWd8uFvW
 v6hhXQ9pAFtvjig2N0sio/Ri48azl3J8SV0zogrKdC3TEN1bt2pHZReuiyaOYZ7XsIvTn1pt
 Ss0ybAKpIO2cDUJxZk5yRPSZP+KfpWG7B/+SOucJypzinF9eL+nmRq+7Uytxvf/W8S0ylpGs
 DdJn9jWun0PyxDe7NWMROFn8Ue7wzmP0hje6uRDIU8pi6XWM4UhwrsslpoLtkTDAzP2lF32j
 KCIckUk/fCl6+H9bbXnop+QLpd0igPjPqg3lMyyA/g0PhIBX2ic/uS827nj8lPjTLpWif02l
 7HVsJHcJcsFuq60GxFZ3pon5hqlDDqr0M4UkWcaIF9EYh6KjZTlN0nLIP/iDPe/h1qskC1sx
 /DDJrDgApTMLnjZn7fgYbpx90BRxREuzd9D/ZJYEK8OL+/uWkPprtzXEgc5MxCow+bgENh90
 oIeWWSSAq6WKa/SskGH5vgpI+aSYI8Yoyj9K/c76P70l3M5mkESfbOv3ZQJbHC0BPNmI1+WY
 SmkvtBUKnsHpgozSqTQj0GCTjNXYz7mRKwmzjoyDojgBJreScaqmrPH1TrtTbNMYWUTO1GeE
 WrvP7eEUvZEPDOAIsZgymRffaWqUcks2Qz451yy8KZuMueBon5QjpnkztUgorSLzXkP
IronPort-HdrOrdr: A9a23:nYfjE6ETXaKrQwbqpLqE08eALOsnbusQ8zAXPo5KOGVom62j5r
 iTdZsgpHrJYVoqKRMdcJW7Scq9qBDnlKKdg7NhWYtKNTOO0ACVxcNZjbcKqAeQfBEWmNQts5
 uIsJISNDQzNzJHZArBjzVQ2uxNruW6zA==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.84,262,1620716400"; 
   d="scan'208";a="59233271"
Received: from mail-pj1-f70.google.com ([209.85.216.70])
  by smtp-lax3-3.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Jul 2021 17:38:25 -0700
Received: by mail-pj1-f70.google.com with SMTP id a14-20020a17090a480eb02901726198443cso1962240pjh.8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 17:38:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=90ZPYQIIxrEQ8HDZV+gD6wEa3lFewktyltoq5V1ZqsU=;
        b=MR/y21+s/XKr/FKiUwMR/VSwexdejYMCtcjkxGhZ8IIk1pWhrH2Cjxi/cGZTHlF/fJ
         F0KBtGH7mmAU6WS1RXCBJhIWCMIpk9RR2yw1kyI8XgGxQ96sTIHm215rdr2qLwWN4/xO
         z4fYhB5sdm9Iy4Z9gr2kX3LWO4Jq00oX++mUYrUqBps0F+POGKTx/4k92KQKPg2CTH2h
         lSc+FU4QHc74MmlTF7NRCLvFHYa5q9Dnmy9vOXVVdmMlk9xy2co2HiAQb9ilVoWZs/3F
         itI7pbi0LCs7Tm8TpJNEjk9PhP4Mqz2ICChDa99gACfXk6LhZNxBmMQOqP6/yJVXEiZL
         RkOw==
X-Gm-Message-State: AOAM531kMz2q7IK7CkRdA2rq5ibGbRSsMm7dboNSyclbfBaw/my+cYBZ
        nsL9oKZLwJmjobCX0WNB2OmUqijeTApgXBqFdjoKCMdiPtb+smwKBOdLnf9spBN6foQ9CaoLpWQ
        OsXSZfA7i5BM2SngImpEM4ro9t/aGbebsqDZ5Zf6/hQ==
X-Received: by 2002:a17:90b:398:: with SMTP id ga24mr11456559pjb.121.1627000704544;
        Thu, 22 Jul 2021 17:38:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzIHA+T7QwOB27+FG13Zxg0HUbQ8YtotMnwZ+asHHHo2WfeTzlqpgN8f79HzchI2DS3NyN7z9l+Ta6SYXxfpRU=
X-Received: by 2002:a17:90b:398:: with SMTP id ga24mr11456528pjb.121.1627000704061;
 Thu, 22 Jul 2021 17:38:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210723085145.1ce7ee5c@canb.auug.org.au>
In-Reply-To: <20210723085145.1ce7ee5c@canb.auug.org.au>
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Date:   Thu, 22 Jul 2021 17:38:13 -0700
Message-ID: <CABvMjLTTtAwH7tT96TQ8THkCjTGUe-bMij449UALoyTSS94amQ@mail.gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the v4l-dvb-next tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All:
I've fixed this issue and resend the patch to the maintainers. I'm so
sorry for the inconvenience.
Stephen:
It seems you are not in the maintainers' mailing list, should I send a
copy to you as well?


On Thu, Jul 22, 2021 at 3:51 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> In commit
>
>   c275e5d349b0 ("media: atomisp: fix the uninitialized use and rename "retvalue"")
>
> Fixes tag
>
>   Fixes: ad85094 (media / atomisp: fix the uninitialized use of model ID)
>
> has these problem(s):
>
>   - SHA1 should be at least 12 digits long
>     Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
>     or later) just making sure it is not set (or set to "auto").
>   - Subject does not match target commit subject
>     Just use
>         git log -1 --format='Fixes: %h ("%s")'
>
> maybe you meant
>
> Fixes: ad85094b293e ("Revert "media: staging: atomisp: Remove driver"")
>
> --
> Cheers,
> Stephen Rothwell



-- 
Kind Regards,

Yizhuo Zhai

Computer Science, Graduate Student
University of California, Riverside

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCFB3F2E59
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 16:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240957AbhHTOqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 10:46:18 -0400
Received: from mout.gmx.net ([212.227.17.20]:47153 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240913AbhHTOqR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 10:46:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629470733;
        bh=n4X6DJOEqFwEFWpjfOg65FUzEilPXcYTNaRllmu5jVU=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
        b=idfM1A6NKdXmsvnI2W3oiGiEPVveAGs6nSxtGKjir7ums3mHn52crhIQ55AIwFnwi
         4CFCsAngLMp1CLgAs//IVxPkMZTflSy4XHkv4wDywJxz/moPFlAV+VcbtLx05oAt/2
         vOPUZQud/9StHeRbgXdjc/8lpAyqSBwlEMq/4GxE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from titan ([79.150.72.99]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MI5QF-1mJct82dF9-00F9vN; Fri, 20
 Aug 2021 16:45:33 +0200
Date:   Fri, 20 Aug 2021 16:45:15 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     kernelnewbies@kernelnewbies.org, linux-kernel@vger.kernel.org
Subject: Contributing to drivers/staging area
Message-ID: <20210820144515.GA5479@titan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:QhWN7jIhqC2aeTk5nWuLmHyS2pZv/McCiP4y0+OQaSj/UqM/k2h
 S/1WfoD24D/81q22LRC147nVYVpbTjT9A2uuLnfvRhYVV3eU8+u8kh/BwCRbK2hydLDxCyN
 tRt9hM5v3AVSvlMPSE9C9p6jlhT9lmcyKDQLRVDa6r27ZwSH+3av3ywnS4IlxiEw9KwfKWp
 ycLanZ6Q42wpSyS08oxsQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qcbXpxToF8k=:C9lhMGN9JtPeQtZat2FD98
 A7XWyh19a+tyD6ZNTcWXldIcE4wBkypLo0TvAvABkZEJqx5UDz3NdaDUqr7BDIo6nB0+LLVXt
 vVAiFrlF27Ct58fjNFE4L8rXv2Ysw3aCHbBNiKHPyQTKI+csxR7Oj0+BcPMsUicUmXn6iEznf
 wNv/PYF+9eD6XKA5yk3o7EYNcAgOqXR81T/Gjc4ET1V/2568ZGDftENKzJz4egAEmL+SZ7JYa
 GuLPGS0bZ6m3WDTUGpSvAqZW+R/jFh26qQAjYODrtnn1x0zqGB+9l/8uVArFvxwIERMBoKLMQ
 u2EEFolKre71dsWlcMnZqcCENcgaIiOoeRbozdNvrwudtPRuBhlIVdoeOYFN1H3Vnl9pBOLcC
 /ogoDa9uNINvSVG/f8EX3zsRTlha+B0SDhexgmvxlq3+/RUO1qZ7a4EsKVhArhOWFWNhaiqO7
 e5gGSvNJX0U4advtGJ16Q9q8gKy/KYuYNJdvnyttNZW3ciRCiVX+j+cxSA7dZo+2c7mPA77gv
 FCYXmyNRkwTxycsxFHWLVt3nMccJqI3wN8OJeQ9PaP1qXyfUKBMC7Q0ba+H4zyXSkL9ezNfpV
 EhkAZzbdTk/6WfibvUMLJDkDe7C3CdC/vxVqMqqH0SQcWNLAPpm7pck+X6lhu7GA2OjWrDoOU
 1U+Oz+TO/fVWRvG8TbRY+R5/MWKvMAW0w0dBKL1qcagzhrPJx2tpwBLH+znNZY2+WeRy5eqoH
 EgA6Nb/0BAMu1x29qUk37SQJMUvO7cy/SD90IEsOKdL25b4CpoYJtYfff7ydBgltK4UdDKpmF
 j463bD7djUiHJjL8dAaqJ2x6yR5CPpBAxQhhoMwE9zYg7No/qHENju3VAcmQiUu+5EpYKciI7
 n0wjWLNexgNmy4JtVLj8DllJo8zX2wvPi2ZN/xNz1jpLrj/XjmXeOAcKHoC3fq7kIfpqEWbMN
 zqEy6b5q6zyARTRkHp4GlKSWol/g9K0JLD90PWylTBgQmGYDgwr0gnrK6ec7vuk9pYkmg4UkA
 J82JCHGVfCzGp8/N2jqr7lG2JVPezCWDqOtrI8RDhnJZpjNczBcJh+t8OIT8zIi3YwHp+aM2Z
 EsvOorG4Ya8n9D5T5o0wuQZN+o/E1wQDRjOSLQREVLeMZjEwK9NDpu/UQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

I am a kernel newbie in the path to find an area where to contribute
on. I have sent some patches before (simple ones) but I would like
to find some driver to contribute on and if possible mantain in the
future. Due to the big amount of drivers in staging, and my lack
of experience and specific hardware:

Are there any driver in the staging area that not requires specific
hardware? I have only access to an old laptop with 4 processors:

vendor_id	: GenuineIntel
cpu family	: 6
model		: 37
model name	: Intel(R) Core(TM) i3 CPU       M 370  @ 2.40GHz

Can I find a driver to contribute on with my machine requirements?
If yes, any advise to select one would be greatly appreciated.

I would like to improve the driver until get it out from staging ;)
And then maintain it.

Another option for me if there are no drivers would be create one
from zero. But I don't have any idea of useful driver. Any advise
and ideas here would be also great appreciated.

Thanks in advance.

Regards,
Len

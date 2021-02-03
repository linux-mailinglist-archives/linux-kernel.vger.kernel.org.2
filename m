Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D64730DFE2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 17:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbhBCQkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 11:40:17 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:7299 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhBCQjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 11:39:51 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B601ad1af0000>; Wed, 03 Feb 2021 08:39:11 -0800
Received: from [10.25.102.154] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 3 Feb
 2021 16:39:07 +0000
Subject: Re: Re: [PATCH 1/2] ASoC: audio-graph: Export graph_remove() function
To:     Mark Brown <broonie@kernel.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <kuninori.morimoto.gx@renesas.com>, <alsa-devel@alsa-project.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sharadg@nvidia.com>
References: <1612368575-25991-1-git-send-email-spujar@nvidia.com>
 <1612368575-25991-2-git-send-email-spujar@nvidia.com>
 <20210203161951.GG4880@sirena.org.uk>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <64b65aaf-9971-e071-5d52-02286fe0cacc@nvidia.com>
Date:   Wed, 3 Feb 2021 22:09:01 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20210203161951.GG4880@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612370351; bh=zQtOgbB7m+FsmzB3eiYRAsuKyqGMXV7NH2ngyTbUPaU=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
         Content-Language:X-Originating-IP:X-ClientProxiedBy;
        b=OBHf5LoDGB/RlsY1s91yGCrRul3cssQmvkcJ0iSmrPdKXCagz9WdoHVssV1AB+TNH
         B/9yzmTSfJ0Z5u7D5ajEps+e6BM0zQyN0tgEGpCAaYqfj7eUG6trxM06w8B2NBudXA
         kfnkDFOR+dhi9h0Keq+U1Xw7qxo39xnN3CrNqRz9Nb9gx5182jg8G7SJQ7+1NuGZxq
         9LN92l1jjRasxlLWpNR0fBSAxuW8eT5JWm8kcNISi8kRuQC9HaHouIVXEVUR4sH5Jo
         QfLoUw0FH4R5nOR4zToO8DxTDtIhTZbovaarMTLyclnsdg9oV/XSuWBgAzUs59rmQo
         0qj/aS3UWakHA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/3/2021 9:49 PM, Mark Brown wrote:
> On Wed, Feb 03, 2021 at 09:39:34PM +0530, Sameer Pujar wrote:
>
>> +int graph_remove(struct platform_device *pdev);
> I think this needs better namespacing if it's going to be exported.

audio_graph_remove() can be a better choice?

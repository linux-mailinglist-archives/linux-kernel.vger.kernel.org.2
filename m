Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5AA350777
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 21:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236212AbhCaTg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 15:36:28 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:36849 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236033AbhCaTgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 15:36:23 -0400
Received: by mail-ot1-f47.google.com with SMTP id g8-20020a9d6c480000b02901b65ca2432cso20055271otq.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 12:36:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=odF5Y/7tVW6s/7gw91BDPK37+FtjAu1oCBEgCYeADpBBrrak5p7H81kqLgUbE61gk7
         zYJZHtTk67mmt/vjUlIlQFCuNwmFVkyZPAKYYfdpCgszoIJJ9k8/GyMqCHBtt2ffeAjK
         aJk2XArdi9++97VuadtevBVpYF737eHmy8ODtUhZHN43htrbkxXyfTR3GK5yuOdNQzWc
         jEQMDGcCIcgtvpydVElc3qU7V/+RU3HfACbq+sbiVXcs2kOlCbN6wzHKXf+Mgf5zj8Tb
         HOsuV99QQwHhyLitMbm3HZx1BM8w/8Cv9IPGAW8J08ujneM3HEzEFWFSgnOi8cFZg0Vo
         C9KQ==
X-Gm-Message-State: AOAM530Rzinz+o74wyPt9L0I2cLQSzg3PHp5ihWRNt/1T1LewD7jhet+
        yVbl/I0gTcURqUTGh4x8qDA=
X-Google-Smtp-Source: ABdhPJySChm/VYBcjuXrCZ4sYKbWRNOlVNtA3Fzd2pgMwMW1nJFynxt2gvMG40YDXpuJw0aU4RLd4A==
X-Received: by 2002:a9d:2f24:: with SMTP id h33mr4053945otb.128.1617219383103;
        Wed, 31 Mar 2021 12:36:23 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:6302:5415:8f3:c3fc? ([2600:1700:65a0:78e0:6302:5415:8f3:c3fc])
        by smtp.gmail.com with ESMTPSA id f29sm683079ots.22.2021.03.31.12.36.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Mar 2021 12:36:22 -0700 (PDT)
Subject: Re: [PATCH] nvme: Export fast_io_fail_tmo to sysfs
To:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Chao Leng <lengchao@huawei.com>,
        Victor Gladkov <Victor.Gladkov@kioxia.com>
References: <20210331131228.131118-1-dwagner@suse.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <6d68ce76-1db7-6f6a-9c6f-38824a49e728@grimberg.me>
Date:   Wed, 31 Mar 2021 12:36:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210331131228.131118-1-dwagner@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

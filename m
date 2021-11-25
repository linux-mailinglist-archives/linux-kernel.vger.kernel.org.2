Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 380AC45DEC2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 17:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356592AbhKYQuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 11:50:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356494AbhKYQsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 11:48:10 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E33C0619D5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 08:27:01 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id b67so12184891qkg.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 08:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bxC8r0/SLBs16FZUakENVihd+Gr81l2H/jBCxluJk2s=;
        b=kt35HcBQ4m2U3mwfIUNPWgyNGcelLGjjHfLw1GhpO7gmMi2s7PACWDze966bV3HJ0w
         szlarEBXTDLYDo5eXztwDGqMuOQz+xUxKp/cI/j1Q7mhMniBYB36RGLhr9+1MhgwF2Sr
         v2JP7ZsmmxVr7o81eTMStpTp4f2qmnCVPnOVC/RqM7BCZ13rCBl31fWSuhuy9iEZTQw0
         nVHRPtyU2gSs246CtvNJQ/Ndaq8UdOr/Wgx8Ift3N5khwpb2xIt1XMUHpuHUYA9K/B2d
         tQZo58c/uSXQyX3q0OBfnOr2E3Kjo5N5bDIScfWiq6Ky5sFNvD2pGhqj/GVD7jCyJmtQ
         tDlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bxC8r0/SLBs16FZUakENVihd+Gr81l2H/jBCxluJk2s=;
        b=Q0NKys2XL8XUuZwbKunl4ij/fn1r/de8IOJydP++EcHUOJzdZiwMZa/7L0Ykav/0zT
         ZWvfC8exhcCpRUNu+yPua6pRkHBt1WrcAtVqi0Frnbl5IP84BVtdBIh53IpS9MG6cpxE
         PS7mvyZRAtbxHX+om9dR3tGD8E4K0CmOEqOFkEsujFlENTYvZrD9OYciQV6D9ZdhUeLf
         sFgvS87DpFAI6Ohp8+Hlumnb0sfcx1t3/DZ4PIIvH7QFrPauFzqy2OyTH5gXnb/qUfzN
         QFnd6tym6L9FtezZQ3pCKUSpMeMc2Z7zwVWqntKGxdaoXf28TJv/bNUrSU3elZKlKZrQ
         B/ZQ==
X-Gm-Message-State: AOAM531BBGXc7jCZcgblYuA3rjZPJi1Mmy7F9q8cT/fhdZ6vnFIrzCaD
        qnrPDeudxeA7yPySS2RhXSLzo773EOE=
X-Google-Smtp-Source: ABdhPJzq8hFEriHIhgNSXqli/i1dfiknsy/LI+st97o65vBwooMS77LjL9jXMIcFoifgZjdvz6/oYA==
X-Received: by 2002:a05:620a:46ac:: with SMTP id bq44mr16993054qkb.414.1637857620430;
        Thu, 25 Nov 2021 08:27:00 -0800 (PST)
Received: from [192.168.1.201] (pool-108-18-207-184.washdc.fios.verizon.net. [108.18.207.184])
        by smtp.googlemail.com with ESMTPSA id g12sm1759780qtk.69.2021.11.25.08.26.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Nov 2021 08:27:00 -0800 (PST)
Subject: Re: [PATCH v2 1/2] tools/vm/page_owner_sort.c: Sort by stacktrace
 before culling
To:     weizhenliang <weizhenliang@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Changhee Han <ch0.han@lge.com>,
        Tang Bin <tangbin@cmss.chinamobile.com>,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
References: <22bad523dffb4681a201e6fedef7c50d@huawei.com>
From:   Sean Anderson <seanga2@gmail.com>
Message-ID: <bf1b7d78-9945-c3be-ff1b-53cf5d3f0878@gmail.com>
Date:   Thu, 25 Nov 2021 11:26:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <22bad523dffb4681a201e6fedef7c50d@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/25/21 4:46 AM, weizhenliang wrote:
> On 2021/11/25 3:37, Sean Anderson <seanga2@gmail.com> wrote:
> 
>> static int compare_num(const void *p1, const void *p2) @@ -121,6
>> +122,7 @@ static void add_list(char *buf, int len)
>> list[list_size].page_num = get_page_num(buf);
>> memcpy(list[list_size].txt, buf, len);  list[list_size].txt[len] = 0;
>> + list[list_size].stacktrace = strchr(list[list_size].txt, '\n');
> 
> When read_block gets an empty line, buf is "\n", then the stacktrace is NULL
> 
>> list_size++;
>> if (list_size % 1000 == 0) {
>> printf("loaded %d\r", list_size);
>> @@ -199,7 +201,7 @@ int main(int argc, char **argv)
>>
>> printf("sorting ....\n");
>>
>> - qsort(list, list_size, sizeof(list[0]), compare_txt);
>> + qsort(list, list_size, sizeof(list[0]), compare_stacktrace);
>>
>> list2 = malloc(sizeof(*list) * list_size);  if (!list2) { @@ -211,7
>> +213,7 @@ int main(int argc, char **argv)
>>
>> for (i = count = 0; i < list_size; i++) {  if (count == 0 ||
>> - strcmp(list2[count-1].txt, list[i].txt) != 0) {
>> + strcmp(list2[count-1].stacktrace, list[i].stacktrace) != 0) {
> 
> And when stacktrace is NULL, a segmentation fault will be triggered here.

Ah, whoops. Looks like I check for this in compare_stacktrace but not here.

>> list2[count++] = list[i];
>> } else {
>> list2[count-1].num += list[i].num;
> 
> 1. Maybe you can check whether the ret of read_block is 0 before add_list,
> or whether the len of buf is 0 in add_list

I think this is the best route.

Since this seems to have already been applied I've sent a follow-up patch.

--Sean


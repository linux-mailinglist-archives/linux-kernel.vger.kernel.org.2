Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAF5D40FCC7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 17:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244566AbhIQPlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 11:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243832AbhIQPlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 11:41:22 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21138C0613DF
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 08:39:57 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id x7so9498187pfa.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 08:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zAx8895jLCwD3sFYKmRbg4TzqLWFAo9rnvyPXtOKZyE=;
        b=dZkB91TGpUY83cnkYYmwLI0QYqypaAkinyPWxyjUO8cbAQHjuRgaeRPojwBCYhAsIG
         kqBvKEjvFqeyVkOJCHtlNy5u7GQqPRV+XEU33+Ve1/oihk348uSsWw2rP7jBOrCze1fQ
         Z3/grfhhUY5VdweSP8vzGGsEdMq79CeK9Wyk+hoogbTz5q6bPwyZPzhLQ8+MWz+eh/ml
         tU97Kw3Dnpm5HHKjl9K2ExSQiZoCimfkRq+ycGsxDvObwtEhYm2XyGBsD88rE03tXMKg
         +0LfHf6fSjr/EUfqXbmyAEU4lJHIVjlAgqua7usanQuS+OGAMfEEm8J8gP1ZT1tMUelz
         kI4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zAx8895jLCwD3sFYKmRbg4TzqLWFAo9rnvyPXtOKZyE=;
        b=og1v5J0ljIHa3WkNG4zEjnhImIdRDSgr3DQy40OC/2VkSxXp0MvW2XazsKztunQJDL
         81MfgvyNQSdqT1sPziUbw7TqFMP07luyWDZn24k/b/SXiiT6iDbIRtbabLrrpKmRa/sx
         9A+qxftpsge1T+2WQ3D7J0c3osusvE3/7paQotSRDjYuJKSBKi7QVY938TvCqvjwo1yf
         1o5u4F+D3xEdk1RLHavlZgbSMNtcz13yryBwMhLsxRXLE/zuuU8EiVJGuKvsspeiUDqd
         wTg+3X+TIqXKdf0/7wllKJMob/IH3W8QJIKL9nD/FuxE6hk81lVq4Nmxm440UxHBmYjs
         sqSQ==
X-Gm-Message-State: AOAM5308P0+1C9AwSKV90+TJU3eSoJd7Y7rbGrC8xk5KWqnVl6KBIecU
        Kp8qm1uhaAU43XHNH6pOF1iIvb7BUkuRPQ==
X-Google-Smtp-Source: ABdhPJw532Os2KQR7nCa/DKqcmrjISHsXusbiG3O9ZwiSG30koCXwXAry2A5YciQTqxCw18VREDxXw==
X-Received: by 2002:a62:5c7:0:b029:3e0:dd9c:8fd2 with SMTP id 190-20020a6205c70000b02903e0dd9c8fd2mr11473473pff.28.1631893196237;
        Fri, 17 Sep 2021 08:39:56 -0700 (PDT)
Received: from [192.168.1.6] ([117.98.200.228])
        by smtp.gmail.com with ESMTPSA id 26sm8118810pgx.72.2021.09.17.08.39.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Sep 2021 08:39:55 -0700 (PDT)
Cc:     saurav.girepunje@hotmail.com,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Martin Kaiser <martin@kaiser.cx>,
        Greg KH <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: r8188eu: os_dep: remove unused function
 rtw_android_priv_cmd
To:     Phillip Potter <phil@philpotter.co.uk>
References: <YT413EaBXqIqMttS@user> <YT97MRziXoUFhvXh@kroah.com>
 <CAA=Fs0n5xt5CtkyVcissVfJpP4_QBpCSUStUy=pT1DwXmsyMMg@mail.gmail.com>
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
Message-ID: <6fe84f11-a9f8-0185-6174-19b700196254@gmail.com>
Date:   Fri, 17 Sep 2021 21:09:51 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAA=Fs0n5xt5CtkyVcissVfJpP4_QBpCSUStUy=pT1DwXmsyMMg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/09/21 11:10 pm, Phillip Potter wrote:
> On Mon, 13 Sept 2021 at 17:24, Greg KH <gregkh@linuxfoundation.org> wrote:
>>
>> On Sun, Sep 12, 2021 at 10:46:12PM +0530, Saurav Girepunje wrote:
>>> Remove unused function rtw_android_priv_cmd.
>>>
>>> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
>>> ---
>>>   drivers/staging/r8188eu/include/rtw_android.h |   1 -
>>>   drivers/staging/r8188eu/os_dep/rtw_android.c  | 138 ------------------
>>>   2 files changed, 139 deletions(-)
>>>
>>> diff --git a/drivers/staging/r8188eu/include/rtw_android.h b/drivers/staging/r8188eu/include/rtw_android.h
>>> index f60cf1c82984..86e3ac5f7955 100644
>>> --- a/drivers/staging/r8188eu/include/rtw_android.h
>>> +++ b/drivers/staging/r8188eu/include/rtw_android.h
>>> @@ -42,6 +42,5 @@ enum ANDROID_WIFI_CMD {
>>>   };
>>>
>>>   int rtw_android_cmdstr_to_num(char *cmdstr);
>>> -int rtw_android_priv_cmd(struct net_device *net, struct ifreq *ifr, int cmd);
>>>
>>>   #endif /* __RTW_ANDROID_H__ */
>>> diff --git a/drivers/staging/r8188eu/os_dep/rtw_android.c b/drivers/staging/r8188eu/os_dep/rtw_android.c
>>> index 010d529c8982..bd76177d60f9 100644
>>> --- a/drivers/staging/r8188eu/os_dep/rtw_android.c
>>> +++ b/drivers/staging/r8188eu/os_dep/rtw_android.c
>>> @@ -133,141 +133,3 @@ static int rtw_android_set_block(struct net_device *net, char *command,
>>>        return 0;
>>>   }
>>>
>>> -int rtw_android_priv_cmd(struct net_device *net, struct ifreq *ifr, int cmd)
>>> -{
>>> -     int ret = 0;
>>> -     char *command = NULL;
>>> -     int cmd_num;
>>> -     int bytes_written = 0;
>>> -     struct android_wifi_priv_cmd priv_cmd;
>>> -
>>> -     if (!ifr->ifr_data) {
>>> -             ret = -EINVAL;
>>> -             goto exit;
>>> -     }
>>> -     if (copy_from_user(&priv_cmd, ifr->ifr_data,
>>> -                        sizeof(struct android_wifi_priv_cmd))) {
>>> -             ret = -EFAULT;
>>> -             goto exit;
>>> -     }
>>> -     command = kmalloc(priv_cmd.total_len, GFP_KERNEL);
>>> -     if (!command) {
>>> -             DBG_88E("%s: failed to allocate memory\n", __func__);
>>> -             ret = -ENOMEM;
>>> -             goto exit;
>>> -     }
>>> -     if (!access_ok(priv_cmd.buf, priv_cmd.total_len)) {
>>> -             DBG_88E("%s: failed to access memory\n", __func__);
>>> -             ret = -EFAULT;
>>> -             goto exit;
>>> -     }
>>> -     if (copy_from_user(command, (char __user *)priv_cmd.buf,
>>> -                        priv_cmd.total_len)) {
>>> -             ret = -EFAULT;
>>> -             goto exit;
>>> -     }
>>> -     DBG_88E("%s: Android private cmd \"%s\" on %s\n",
>>> -             __func__, command, ifr->ifr_name);
>>> -     cmd_num = rtw_android_cmdstr_to_num(command);
>>> -     switch (cmd_num) {
>>> -     case ANDROID_WIFI_CMD_START:
>>> -             goto response;
>>> -     case ANDROID_WIFI_CMD_SETFWPATH:
>>> -             goto response;
>>> -     }
>>> -     if (!g_wifi_on) {
>>> -             DBG_88E("%s: Ignore private cmd \"%s\" - iface %s is down\n",
>>> -                     __func__, command, ifr->ifr_name);
>>> -             ret = 0;
>>> -             goto exit;
>>> -     }
>>> -     switch (cmd_num) {
>>> -     case ANDROID_WIFI_CMD_STOP:
>>> -             break;
>>> -     case ANDROID_WIFI_CMD_SCAN_ACTIVE:
>>> -             break;
>>> -     case ANDROID_WIFI_CMD_SCAN_PASSIVE:
>>> -             break;
>>> -     case ANDROID_WIFI_CMD_RSSI:
>>> -             bytes_written = rtw_android_get_rssi(net, command,
>>> -                                                  priv_cmd.total_len);
>>> -             break;
>>> -     case ANDROID_WIFI_CMD_LINKSPEED:
>>> -             bytes_written = rtw_android_get_link_speed(net, command,
>>> -                                                        priv_cmd.total_len);
>>> -             break;
>>> -     case ANDROID_WIFI_CMD_MACADDR:
>>> -             bytes_written = rtw_android_get_macaddr(net, command,
>>> -                                                     priv_cmd.total_len);
>>> -             break;
>>> -     case ANDROID_WIFI_CMD_BLOCK:
>>> -             bytes_written = rtw_android_set_block(net, command,
>>> -                                                   priv_cmd.total_len);
>>> -             break;
>>> -     case ANDROID_WIFI_CMD_RXFILTER_START:
>>> -             break;
>>> -     case ANDROID_WIFI_CMD_RXFILTER_STOP:
>>> -             break;
>>> -     case ANDROID_WIFI_CMD_RXFILTER_ADD:
>>> -             break;
>>> -     case ANDROID_WIFI_CMD_RXFILTER_REMOVE:
>>> -             break;
>>> -     case ANDROID_WIFI_CMD_BTCOEXSCAN_START:
>>> -             /* TBD: BTCOEXSCAN-START */
>>> -             break;
>>> -     case ANDROID_WIFI_CMD_BTCOEXSCAN_STOP:
>>> -             /* TBD: BTCOEXSCAN-STOP */
>>> -             break;
>>> -     case ANDROID_WIFI_CMD_BTCOEXMODE:
>>> -             break;
>>> -     case ANDROID_WIFI_CMD_SETSUSPENDOPT:
>>> -             break;
>>> -     case ANDROID_WIFI_CMD_SETBAND:
>>> -             break;
>>> -     case ANDROID_WIFI_CMD_GETBAND:
>>> -             break;
>>> -     case ANDROID_WIFI_CMD_COUNTRY:
>>> -             bytes_written = android_set_cntry(net, command,
>>> -                                               priv_cmd.total_len);
>>> -             break;
>>> -     case ANDROID_WIFI_CMD_P2P_DEV_ADDR:
>>> -             bytes_written = android_get_p2p_addr(net, command,
>>> -                                                  priv_cmd.total_len);
>>> -             break;
>>> -     case ANDROID_WIFI_CMD_P2P_SET_NOA:
>>> -             break;
>>> -     case ANDROID_WIFI_CMD_P2P_GET_NOA:
>>> -             break;
>>> -     case ANDROID_WIFI_CMD_P2P_SET_PS:
>>> -             break;
>>> -     default:
>>> -             DBG_88E("Unknown PRIVATE command %s - ignored\n", command);
>>> -             snprintf(command, 3, "OK");
>>> -             bytes_written = strlen("OK");
>>> -     }
>>> -
>>> -response:
>>> -     if (bytes_written >= 0) {
>>> -             if ((bytes_written == 0) && (priv_cmd.total_len > 0))
>>> -                     command[0] = '\0';
>>> -             if (bytes_written >= priv_cmd.total_len) {
>>> -                     DBG_88E("%s: bytes_written = %d\n", __func__,
>>> -                             bytes_written);
>>> -                     bytes_written = priv_cmd.total_len;
>>> -             } else {
>>> -                     bytes_written++;
>>> -             }
>>> -             priv_cmd.used_len = bytes_written;
>>> -             if (copy_to_user((char __user *)priv_cmd.buf, command,
>>> -                              bytes_written)) {
>>> -                     DBG_88E("%s: failed to copy data to user buffer\n",
>>> -                             __func__);
>>> -                     ret = -EFAULT;
>>> -             }
>>> -     } else {
>>> -             ret = bytes_written;
>>> -     }
>>> -exit:
>>> -     kfree(command);
>>> -     return ret;
>>> -}
>>> --
>>> 2.32.0
>>>
>>>
>>
>> Does not apply to my tree :(
> 
> Dear Saurav,
> 
> This code is already gone - Linus deleted it during a merge
> conflict resolution. I am planning to add it back soon though
> and reconnect with the newer siocdevprivate approach.
> 
> Regards,
> Phil
> 

Thanks Phil for information.

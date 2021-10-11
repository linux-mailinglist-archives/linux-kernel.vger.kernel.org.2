Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A512429895
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 23:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235149AbhJKVF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 17:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbhJKVF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 17:05:26 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E66DC061570;
        Mon, 11 Oct 2021 14:03:26 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id p68so21339434iof.6;
        Mon, 11 Oct 2021 14:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VpTOmMnYeBAsmZpKSwKJS+8kAPjTggYUu3T1PRR8puw=;
        b=DWamGnG8bmG8X21EnR0ChHMFjln82VqGUosTW7gTqGfbJnbsKpRDtDk95XDFSVcyM6
         3MMwWs5f8h4BIZOrA4mYmwDpHOL52JD8lMpNF/mwfN2yxWbpi9YGG3FMvrIkTJZ9sVOU
         vcqeVv+TJDnsbX1FWpME4OHN0mJGbIFFkiZGlIwEXz5+ruScYFOHc56LLM53ktU7qcTc
         x9U3FmMp/zv08wn60KJuxRPH8NZIIUyfbVydxa2JOkyQGk88qnbRC+iy3omLIyGwXJ01
         pwIQrx0tBNNOze+uh8niuwZGvczhrxsA3qkDrMYDdQHmQ9BrJPGlmPpjEEhXJcrysxVy
         k2lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VpTOmMnYeBAsmZpKSwKJS+8kAPjTggYUu3T1PRR8puw=;
        b=3nAvL1HKU4YcJUPXeE2HeoZiS/aPg3OXT6Qjxhf8wrZxh2iuJi2VNGvqpx41I73E3z
         SWe+6p/auhCxiVbzmiNNlRNEvQqqdxbS7NmkF9gSe7Ei7VNsSLVRNnJY5e0/A57+IS8h
         T7Pwd+wCs01Il+mWUlJoQ/jlPj1XrFxIg0j2bfBRKSLYL4F6kw9o+7WjZjcii5O3UA0Z
         WKGvWwgVBsVgXqVvMQf7btRIjQSIHnda6lB/dXTvXbWfHB4BvsIxK1RxAsynUo4oTL6W
         knnKAMKq9Q09n0TmqSC1lp/uDcChtlDF2c3uVY5INpmChS6jG0Y8JV2nRC8OrpxPIYDM
         IbZQ==
X-Gm-Message-State: AOAM533L+Bts7fZvIru04xtlvZvlUVfAusU+mduiwGR/qCLoSIVYIHbK
        gx8HXCbab99pr6FxklkNt1lsp2TXXatNc4LNIYQ=
X-Google-Smtp-Source: ABdhPJzi9/gjwxSZ7bmJ0i3RpOAZy2AEW8HH88NtQ9J7F/6skXH3IiVp6v+0qkoiL8LEwek/nQh7AnpHXvVKyQmEBsI=
X-Received: by 2002:a05:6638:37a7:: with SMTP id w39mr21016254jal.19.1633986205891;
 Mon, 11 Oct 2021 14:03:25 -0700 (PDT)
MIME-Version: 1.0
References: <20211011195503.23153-1-pauk.denis@gmail.com> <20211011195503.23153-2-pauk.denis@gmail.com>
In-Reply-To: <20211011195503.23153-2-pauk.denis@gmail.com>
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Date:   Mon, 11 Oct 2021 23:03:14 +0200
Message-ID: <CAB95QASjUq4P3HhFJrCpBwtJLzwc0ig0q5YQg6FGTDaxkS3SPg@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] hwmon: (asus_wmi_ec_sensors) Support B550 Asus WMI.
To:     Denis Pauk <pauk.denis@gmail.com>
Cc:     andy.shevchenko@gmail.com, platform-driver-x86@vger.kernel.org,
        Tor Vic <torvic9@mailbox.org>,
        kernel test robot <lkp@intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Denis,

> +       for (i_sensor = 0; i_sensor < ec->nr_sensors; i_sensor++) {
> +               s = &ec->sensors[i_sensor];
> +               si = &known_ec_sensors[s->info_index];
> +
> +               switch (si->addr.size) {
> +               case 1:
> +                       s->cached_value = ec->read_buffer[read_reg_ct];
> +                       break;
> +               case 2:
> +                       s->cached_value = get_unaligned_be16(&ec->read_buffer[read_reg_ct]);
> +                       break;
> +               case 4:
> +                       s->cached_value = get_unaligned_be32(&ec->read_buffer[read_reg_ct]);
> +                       break;
> +               default:
> +                       s->cached_value =  0;
> +               }
> +               read_reg_ct += si->addr.size;

There is at least one more sensor hiding in the EC address space: the
south bridge voltage. And it seems its value is not an integer, so the
conversion to mV will not be a simple get_unaligned_xx() call when we
locate and add it. Thus, I would suggest extracting this switch in a
separate function to make the future modification simpler. Something
like the following:

static inline u32 get_sensor_value(const struct ec_sensor_info *si, u8
*data) // si for the data encoding scheme
{
    switch (si->addr.components.size) {
    case 1:
        return *data;
    case 2:
        return get_unaligned_be16(data);
    case 4:
        return get_unaligned_be32(data);
    }
}

static void update_sensor_values(struct ec_sensors_data *ec, u8 *data)
{
    const struct ec_sensor_info *si;
    struct ec_sensor *s;

    for (s = ec->sensors; s != ec->sensors + ec->nr_sensors; s++) {
        si = &known_ec_sensors[s->info_index];
        s->cached_value = get_sensor_value(si, data);
        data += si->addr.components.size;
    }
}

Additionally, this would simplify update_ec_sensors() body:

mutex_lock(&ec->lock);
make_asus_wmi_block_read_query(ec);
status = asus_ec_block_read(dev, METHODID_BLOCK_READ_EC, ec->read_arg,
    buffer);

if (!status) {
    update_sensor_values(ec, buffer);
}
mutex_unlock(&ec->lock);


Eugene

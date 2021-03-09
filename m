Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08E86331DB5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 04:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbhCIDuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 22:50:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbhCIDt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 22:49:58 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F051CC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 19:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=Em4tvMXPYiKF+oE0u3rKmZiyAST6rAz5Klub7t+/W7M=; b=KTNOWwIYqzDsSmXgVPJcvClkl7
        mcJ8iGITlOTpKzIUp1tsuwr6UYPEd+Icwq7HRb22ih2+WpsYczs5sKpGCNH8v5q2lxhgjQFZb2IKy
        0CJgs6JTMQxKPSGwp/gtJN88jyTucD+vBigTRgY4mK53W2RPr2QeAOn4oAxtLh5VQh2PQP5kJJAkk
        VDGtUN13AoRnGcnTzVw56GHq9HN4yu+lcnI+f6o9Kn+vS/XzfAaLwbUXzXsNd1XKPWRhnrQXfnzLd
        fBR4ArtG2U1eq3tkgI2WETdwtoiKaAo4k6SXAe3gGhGwslMUT/9nU5hr6c4ATlhcLNxyFSuU2fYWv
        CjIUM20w==;
Received: from [2601:1c0:6280:3f0::3ba4]
        by merlin.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lJTNb-000bxU-CO; Tue, 09 Mar 2021 03:49:56 +0000
Subject: Re: [PATCH] soc: qcom: Fix typos in the file qmi_encdec.c
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, agross@kernel.org,
        bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210306213542.19413-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <080d15f5-6f91-68fe-a135-87269b722a3d@infradead.org>
Date:   Mon, 8 Mar 2021 19:49:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210306213542.19413-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/21 1:35 PM, Bhaskar Chowdhury wrote:
> 
> Rudimentory spelling fixes throughout the file.
> 
> s/descibing/describing/
> s/inforation/information/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>


> ---
>  drivers/soc/qcom/qmi_encdec.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/soc/qcom/qmi_encdec.c b/drivers/soc/qcom/qmi_encdec.c
> index 3aaab71d1b2c..328cc8237191 100644
> --- a/drivers/soc/qcom/qmi_encdec.c
> +++ b/drivers/soc/qcom/qmi_encdec.c
> @@ -451,11 +451,11 @@ static int qmi_decode_basic_elem(void *buf_dst, const void *buf_src,
> 
>  /**
>   * qmi_decode_struct_elem() - Decodes elements of struct data type
> - * @ei_array: Struct info array descibing the struct element.
> + * @ei_array: Struct info array describing the struct element.
>   * @buf_dst: Buffer to store the decoded element.
>   * @buf_src: Buffer containing the elements in QMI wire format.
>   * @elem_len: Number of elements to be decoded.
> - * @tlv_len: Total size of the encoded inforation corresponding to
> + * @tlv_len: Total size of the encoded information corresponding to
>   *           this struct element.
>   * @dec_level: Depth of the nested structure from the main structure.
>   *
> @@ -499,10 +499,10 @@ static int qmi_decode_struct_elem(struct qmi_elem_info *ei_array,
> 
>  /**
>   * qmi_decode_string_elem() - Decodes elements of string data type
> - * @ei_array: Struct info array descibing the string element.
> + * @ei_array: Struct info array describing the string element.
>   * @buf_dst: Buffer to store the decoded element.
>   * @buf_src: Buffer containing the elements in QMI wire format.
> - * @tlv_len: Total size of the encoded inforation corresponding to
> + * @tlv_len: Total size of the encoded information corresponding to
>   *           this string element.
>   * @dec_level: Depth of the string element from the main structure.
>   *
> --


-- 
~Randy

